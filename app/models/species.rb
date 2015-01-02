class Species < ActiveRecord::Base
  belongs_to :family, class_name: 'Categories::Family', foreign_key: 'category_id'
  belongs_to :parent, class_name: 'Species'
  has_many :children, class_name: 'Species', foreign_key: 'parent_id'

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates_presence_of :name_ru, :name_lat, :name_en

  def sub_species
    Species.where(parent_id: id)
  end
end
