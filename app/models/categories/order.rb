class Categories::Order < Categories::Category

  def families
    children.order(:name_ru)
  end
end
