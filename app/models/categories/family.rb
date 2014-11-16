class Categories::Family < Categories::Category
  has_many :species, foreign_key: 'category_id'
end
