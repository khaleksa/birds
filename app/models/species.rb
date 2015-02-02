class Species < ActiveRecord::Base
  belongs_to :family, class_name: 'Categories::Family', foreign_key: 'category_id'
  belongs_to :parent, class_name: 'Species'
  has_many :children, class_name: 'Species', foreign_key: 'parent_id'

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :birds

  validates_presence_of :name_ru, :name_lat, :name_en

  def sub_species
    Species.where(parent_id: id)
  end

  def default_image
    images.detect { |image| image.default } || images.first
  end

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
