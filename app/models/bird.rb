class Bird < ActiveRecord::Base
  belongs_to :user
  belongs_to :species
  belongs_to :expert, class_name: 'User'

  has_many :comments, -> { order 'created_at' }, dependent: :destroy

  mount_uploader :photo, ImageUploader

  validates_presence_of :user_id

  after_create :set_big_year
  before_update :update_big_year

  scope :published, ->() { where(:published => true) }
  scope :unpublished, ->() { where(:published => false) }
  scope :known, ->() { where('species_id IS NOT NULL') }
  scope :unknown, ->() { where('species_id IS NULL') }
  scope :unconfirmed, ->() { where('expert_id IS NULL') }
  scope :approved, ->() { where('expert_id IS NOT NULL') }
  scope :with_comments, ->() { joins(:comments) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :no_hybrid, ->() { where('species_id != ?', Rails.configuration.hybrid.species.id) }

  scope :commentable_feed, ->() do
    comments_relation = Comment.select('bird_id', 'max(updated_at) AS last_date').group('bird_id')
    joins("INNER JOIN (#{comments_relation.to_sql}) bc ON bc.bird_id = birds.id").order('last_date DESC')
  end

  def unknown?
    species_id.blank?
  end

  def can_publish?
    photo.present? && timestamp.present? && address_valid?
  end

  def address_valid?
    latitude.present? && longitude.present?
  end

  def address_string
    address.present? ? address : "#{latitude}; #{longitude}"
  end

  def publish!
    update_attribute(:published, true)
  end

  def need_approve?
    expert.blank? && species.present? && species_id != Rails.configuration.hybrid.species.id
  end

  def show_map_for(user)
    return true if species.blank? || owner?(user)
    return species.show_map_for(user)
  end

  def species_name
    self.species ? self.species.name : 'Вид не определен'
  end

  def owner?(user)
    user_id == user.try(:id)
  end

  private
  # Bird is participant of BigYear if it's user is participant of BY and photo was made & downloaded during the current year
  def set_big_year
    current_year = Time.zone.now.year
    return unless user.subscribed?(current_year)
    self.update_attributes(big_year: current_year) if timestamp.try(:year) == current_year
  end

  # Bird's big_year attribute can be changed only during the year of it's creating
  def update_big_year
    current_year = Time.zone.now.year
    return unless (created_at.year == current_year) && timestamp_changed?
    if user.subscribed?(current_year) || big_year == current_year
      self.big_year = timestamp.try(:year) == current_year ? current_year : 0
    end
  end
end
