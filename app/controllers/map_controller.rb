class MapController < ApplicationController
  include DateHelper
  layout 'map'

  def index
    @species = Species.find(params[:species_id])
    @birds = @species.birds.approved

    respond_to do |format|
      format.html
      format.json { render json: birds_json_data(@birds) }
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
