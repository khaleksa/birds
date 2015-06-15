class MapController < ApplicationController
  include DateHelper
  layout 'map'

  def index
    @species = Species.find(params[:species_id])
    @birds = @species.birds

    respond_to do |format|
      format.html
      format.json { render json: birds_json_info(@birds) }
    end
  end

  private
  def birds_json_info(birds)
    data = []
    birds.each do |bird|
      bird_data = {
          lat: bird.latitude,
          lng: bird.longitude,
          author: bird.user.full_name,
          author_link: profile_url(bird.user),
          timestamp: date_format(bird.timestamp),
          address: bird.address_string,
          image_url: bird.photo.thumb.url
      }
      data<<bird_data
    end
    data.to_json
  end
end
