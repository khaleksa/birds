class Categories::Category < ActiveRecord::Base
  validates_presence_of :name_ru, :name_lat, :name_en, :name_uz

  acts_as_tree :order => 'name_ru'

  mount_uploader :image, CategoryUploader

  scope :orders, -> { where(type: 'Categories::Order').order(:name_ru) }
  scope :families, -> { where(type: 'Categories::Family').order(:name_ru) }

  def full_name
    result = ''

    names = [name_ru, name_en, name_lat, name_uz].compact.reject(&:empty?)
    names.each_with_index do |name, index|
      result += ' (' if index == 1
      result += ' | ' if [2, 3].include?(index)
      result += name
    end
    result += ')' if names.size > 1

    result
  end
end
