class Bird < ActiveRecord::Base
  belongs_to :user
  belongs_to :species

  # has_many :photos, dependent: :destroy
  # accepts_nested_attributes_for :photos, allow_destroy: true

  mount_uploader :photo, ImageUploader

  validates_presence_of :user_id

  def can_publish?
    photo.present? && timestamp.present? && species.present? && address_valid?
  end

  def address_valid?
    latitude.present? && longitude.present?
  end
end
