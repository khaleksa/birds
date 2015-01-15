class PagesController < ApplicationController

  def index
    @birds = Bird.where('photo IS NOT NULL').order(:created_at).limit(8) #todo
  end

  def big_year
    @stat = Stats::Counts.new
    @species_list = @stat.big_year_species
  end
end
