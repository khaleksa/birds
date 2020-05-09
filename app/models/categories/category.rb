class Categories::Category < ActiveRecord::Base
  translates :name, :description
  globalize_accessors :locales => [:ru, :en, :uz], :attributes => [:name, :description]
  
  validates_presence_of :name_ru, :name_lat, :name_en, :name_uz

  acts_as_tree :order => 'name_lat'

  mount_uploader :image, CategoryUploader

  scope :orders, -> { with_translations([[I18n.locale]]).where(type: 'Categories::Order').order("category_translations.name ASC") }
  scope :families, -> { with_translations([I18n.locale]).where(type: 'Categories::Family').order("category_translations.name ASC") }

  def full_name
    result = ''

    names = [name_ru, name_lat, name_uz, name_en].compact.reject(&:empty?)
    names.each_with_index do |name, index|
      result += ' (' if index == 1
      result += ' | ' if [2, 3].include?(index)
      result += name
    end
    result += ')' if names.size > 1

    result
  end
end
