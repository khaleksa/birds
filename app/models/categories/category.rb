class Categories::Category < ActiveRecord::Base
  validates_presence_of :name_ru, :name_lat, :name_en
  validates_uniqueness_of :name_ru, :name_lat, :name_en

  acts_as_tree :order => 'name_ru'

  mount_uploader :image, CategoryUploader

  scope :orders, -> { where(type: 'Categories::Order') }
  scope :families, -> { where(type: 'Categories::Family') }

  def full_name
    result = ''

    names = [name_ru, name_en, name_lat].compact.reject(&:empty?)
    names.each_with_index do |name, index|
      result += ' (' if index == 1
      result += ' | ' if index == 2
      result += name
    end
    result += ')' if names.size > 1

    result
  end
end
