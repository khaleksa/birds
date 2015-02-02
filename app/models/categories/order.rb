class Categories::Order < Categories::Category

  def families
    children.order(:position)
  end
end
