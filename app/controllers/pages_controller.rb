class PagesController < ApplicationController

  def index
    @birds = Bird.where('photo IS NOT NULL').order(:created_at)
  end

end
