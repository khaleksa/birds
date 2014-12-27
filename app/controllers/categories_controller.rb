class CategoriesController < ApplicationController

  def show
    @orders = Categories::Order.all
  end
end
