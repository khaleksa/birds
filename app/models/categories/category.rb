class Category < ActiveRecord::Base
  validates_presence_of :name_ru
  validates_uniqueness_of :name_ru, :name_lat, :name_en

  scope :orders, -> { where(type: 'Order') }
  scope :families, -> { where(type: 'Family') }
end
