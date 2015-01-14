class Photo < ActiveRecord::Base
  belongs_to :bird

  validates_presence_of :photo, :bird

  mount_uploader :image, ImageUploader
end
