class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :roles
  has_many :birds
  has_many :comments, dependent: :destroy

  validates_uniqueness_of :email
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

  #TODO::rating_of_photo_bd
  def self.rating_of_photo_bd
    sql = "
          SELECT users.id, users.first_name, users.last_name, sp.species_count, asp.approved_species_count
          FROM users
          INNER JOIN (
              SELECT user_id, count(DISTINCT species_id) AS species_count
              FROM birds
              WHERE (species_id IS NOT NULL) AND (timestamp::DATE = '2015-12-06') AND (created_at BETWEEN :date_begin AND :date_end )
              GROUP BY user_id
              ) sp ON sp.user_id = users.id
          LEFT JOIN (
              SELECT user_id, count(DISTINCT species_id) AS approved_species_count
              FROM birds
              WHERE (species_id IS NOT NULL) AND (expert_id IS NOT NULL) AND (timestamp::DATE = '2015-12-06') AND (created_at BETWEEN :date_begin AND :date_end )
              GROUP BY user_id
              ) asp ON asp.user_id = sp.user_id
          ORDER BY sp.species_count DESC
    "
    sanitized_sql = ActiveRecord::Base.send :sanitize_sql_array, [sql, date_begin: Time.parse('2015-12-06 02:00'), date_end: Time.parse('2015-12-08 5:00')]
    Bird.find_by_sql(sanitized_sql)
  end

  private
  # super call contains (!persisted? || password.present? || password_confirmation.present?)
  def password_required?
    super && provider.blank? && uid.blank?
  end
end
