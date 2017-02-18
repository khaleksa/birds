class CategoriesController < ApplicationController

  def index
    @orders = Categories::Order.no_hybrid.order(:position).all
  end
end
