class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :roles
  has_many :birds
  has_many :comments

  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name

  scope :big_year_members, ->() { where(big_year: true) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.species_count
    User.sel
  end

  def has_role?(role)
    roles.map(&:name).map(&:downcase).include? role.to_s.downcase
  end

  def current?(current_user)
    id == current_user.id
  end

  def expert?
    has_role?(:expert)
  end
end
