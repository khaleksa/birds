class Categories::Order < Categories::Category

  def families
    children.sort { |f1, f2| f1.position <=> f2.position }
  end
end
