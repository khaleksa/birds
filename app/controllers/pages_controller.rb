class PagesController < ApplicationController

  #TODO: pagination?!
  def index
    @birds = Bird.published.order(created_at: :desc).limit(8)
  end

  def big_year
    @stat = Stats::Counts.new
    @species_list = @stat.big_year_species
  end
end
