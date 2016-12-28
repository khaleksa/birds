require 'statistics/big_year'

class BigYearController < ApplicationController

  def index
    @years = (2015..Time.zone.now.year).to_a.reverse
    year = params[:year].to_i || Time.zone.now.year
    @participants = Statistics::BigYear.users_species_count(year)
    @species = Statistics::BigYear.species(year)
  end

end
