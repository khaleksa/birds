class Categories::Family < Categories::Category
  has_many :species, foreign_key: 'category_id'

  validates_presence_of :parent

  def order
    parent
  end
end
