class PagesController < ApplicationController

  PHOTO_COUNT_PER_PAGE = 8

  #TODO: write test
  def index
    #TODO: Birds published change from boolean to datetime
    @birds = Bird.published.known.order(created_at: :desc).limit(8)
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

  def unknowns
    @birds = Bird.published.unknown.order(created_at: :desc).limit(8)
    #TODO: add show more
  end

  def about
    @users_count = User.count
    @species_count = Stats::Counts.new.birds_species_count
    @birds_count = Bird.count
  end
end
