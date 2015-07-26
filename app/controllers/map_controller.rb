class MapController < ApplicationController
  include DateHelper
  layout 'map'

  def index
    @species = Species.find(params[:species_id])
    @map_url_params = { species_id: @species.id }

    @species_birds = @species.birds.approved
    #TODO: @species_birds = @species_birds.big_year(params[:big_year].to_i) if params[:big_year]
    if params[:user_id]
      @species_birds = @species_birds.by_user(params[:user_id])
      @map_url_params[:user_id] = params[:user_id]
    end

    respond_to do |format|
      format.html
      format.json { render json: birds_json_data(@species_birds) }
    end
  end

  private
  def birds_json_data(birds)
    data = []
    birds.each do |bird|
      bird_data = {
          lat: bird.latitude,
          lng: bird.longitude,
          author: bird.user.full_name,
          author_url: profile_url(bird.user),
          timestamp: date_format(bird.timestamp),
          address: bird.address_string,
          image_url: bird.photo.thumb.url,
          bird_id: bird.id,
          bird_url: bird_url(bird)
      }
      data<<bird_data
    end
    data.to_json
  end
end
