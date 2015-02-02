class CategoriesController < ApplicationController

  def index
    @orders = Categories::Order.order(:position).all
  end
end
