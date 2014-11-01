class Species < ActiveRecord::Base
  validates_presence_of :name_ru, :name_lat, :name_en
  validates_uniqueness_of :name_ru, :name_lat, :name_en

end
