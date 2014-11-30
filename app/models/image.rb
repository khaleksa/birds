class Image < ActiveRecord::Base
  belongs_to :species

  validates_presence_of :image, :species

  mount_uploader :image, ImageUploader
end
