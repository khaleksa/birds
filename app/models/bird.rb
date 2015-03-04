class Bird < ActiveRecord::Base
  belongs_to :user
  belongs_to :species

  has_many :comments, dependent: :destroy

  mount_uploader :photo, ImageUploader

  validates_presence_of :user_id

  scope :published, ->() { where(:published => true) }

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
end
