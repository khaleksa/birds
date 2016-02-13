class Species < ActiveRecord::Base
  belongs_to :family, class_name: 'Categories::Family', foreign_key: 'category_id'
  belongs_to :parent, class_name: 'Species'
  has_many :children, class_name: 'Species', foreign_key: 'parent_id'

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :birds

  validates_presence_of :name_lat, :family

  FRIEND_USERS = [1, 4, 5, 11, 58, 130]

  scope :main, -> { where('parent_id IS NULL') }
  scope :ordered, -> { order('lower(name_ru)') }
  scope :by_name, -> (name) {
    where("(lower(name_ru) like ?) OR
           (lower(name_en) like ?) OR
           (lower(name_lat) like ?) OR
           (lower(name_uz) like ?)", name, name, name, name)
  }

  def active_link?
    description.present? || images.any?
  end

  def sub_species
    Species.where(parent_id: id)
  end

  def default_image
    images.detect { |image| image.default } || images.first
  end

  def default_name
    name_ru.present? ? name_ru : name_lat
  end

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

  #TODO: rewrite
  def show_map_for(user)
    return true if show_map
    return user.try(:expert?) || FRIEND_USERS.include?(user.try(:id))
  end
end
