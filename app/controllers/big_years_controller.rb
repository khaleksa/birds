require 'statistics/big_year'

class BigYearsController < ApplicationController

  def index
    @years = (2015..Time.zone.now.year).to_a.reverse
    @current_year = params[:year].to_i || Time.zone.now.year
    @participants = Statistics::BigYear.users_species_count(@current_year)
    @species = Statistics::BigYear.species(@current_year)
  end

  def change_subscription
    action = (params[:big_year] == '1' ? :subscribe! : :unsubscribe!)
    current_user.send(action, Time.zone.now.year)
    render nothing: true
  end

end
