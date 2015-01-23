class PagesController < ApplicationController

  def index
    #TODO: Birds published change from boolean to datetime
    @birds = Bird.published.order(created_at: :desc).limit(8)
    #TODO: refactoring
    offset = params[:count]
    @birds = @birds.offset(offset.to_i) if offset
    @total_count = @birds.size + offset.to_i

    respond_to do |format|
      format.html
      format.js
    end
  end

  def big_year
    @stat = Stats::Counts.new
    @species_list = @stat.big_year_species
  end
end
