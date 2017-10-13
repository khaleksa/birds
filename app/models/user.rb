class User < ActiveRecord::Base
  include Models::Subscribable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :roles
  has_many :birds
  has_many :comments, dependent: :destroy

  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :email, :first_name, :last_name
  validates :password, presence: true, if: :password_required?

  scope :big_year_members, ->() { where(big_year: true) }

  def full_name
    "#{last_name} #{first_name}"
  end

  def has_role?(role)
    roles.map(&:name).map(&:downcase).include? role.to_s.downcase
  end

  def current?(current_user)
    current_user && (current_user.id == id)
  end

  def expert?
    has_role?(:expert)
  end

  def friend?
    has_role?(:friend)
  end

  def restricted?
    has_role?(:restricted)
  end

  def self.from_omniauth(auth)
    provider = auth[:social_accounts_attributes][:provider]
    uid = auth[:social_accounts_attributes][:uid]
    where(provider: provider, uid: uid).first_or_create do |user|
      user.provider = provider
      user.uid = uid
      user.email = auth[:email]
      user.first_name = auth[:first_name]
      user.last_name = auth[:last_name]
    end
  end

  private
  # super call contains (!persisted? || password.present? || password_confirmation.present?)
  def password_required?
    super && provider.blank? && uid.blank?
  end
end
