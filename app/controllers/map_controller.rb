class MapController < ApplicationController

  layout 'map'

  def index
    @species = Species.find(params[:species_id])
    @birds = @species.birds
  end
end
