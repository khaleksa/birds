class Species < ActiveRecord::Base
  belongs_to :family, :class_name => 'Categories::Family', foreign_key: 'category_id'

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates_presence_of :name_ru, :name_lat, :name_en
  validates_uniqueness_of :name_ru, :name_lat, :name_en
end
