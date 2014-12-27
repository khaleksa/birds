class Categories::Order < Categories::Category

  def families
    self.children.order(:name_ru)
  end
end
