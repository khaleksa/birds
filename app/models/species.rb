class Species < ActiveRecord::Base
  belongs_to :family, :class_name => 'Categories::Family', foreign_key: 'category_id'

  validates_presence_of :name_ru, :name_lat, :name_en
  validates_uniqueness_of :name_ru, :name_lat, :name_en
end
