class Categories::Order < Categories::Category

  scope :no_hybrid, ->() { where('id != ?', Rails.configuration.hybrid.order.id) }

  def families
    children.sort { |f1, f2| f1.position <=> f2.position }
  end
end
