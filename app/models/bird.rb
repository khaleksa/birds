class Bird < ActiveRecord::Base
  belongs_to :user
  belongs_to :species
  belongs_to :expert, class_name: 'User'

  has_many :comments, dependent: :destroy

  mount_uploader :photo, ImageUploader

  validates_presence_of :user_id

  before_create :set_expert

  scope :published, ->() { where(:published => true) }
  scope :unpublished, ->() { where(:published => false) }
  scope :known, ->() { where('species_id IS NOT NULL') }
  scope :unknown, ->() { where('species_id IS NULL') }
  scope :unconfirmed, ->() { where('expert_id IS NULL') }
  scope :approved, ->() { where('expert_id IS NOT NULL') }
  scope :by_species, ->(species_id) { where(:species_id => species_id) }

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
    !user.expert? && expert.blank?
  end

  def show_map_for(user)
    return true if species.blank? || species.try(:show_map)
    return (user.try(:expert?) ? true : false)
  end

  private
  #Set expert_id for bird of expert user
  def set_expert
    return unless user.expert?
    self.expert = user
  end
end
