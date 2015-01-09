class Bird < ActiveRecord::Base
  belongs_to :user
  belongs_to :species

  # has_many :photos, dependent: :destroy
  # accepts_nested_attributes_for :photos, allow_destroy: true

  mount_uploader :photo, ImageUploader

  validates_presence_of :user_id
end
