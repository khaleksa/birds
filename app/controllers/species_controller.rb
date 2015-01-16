class SpeciesController < ApplicationController

  def index
  end

  def show
    species_id = params[:id]
    @species = Species.find(species_id)
    @main_image = @species.default_image
  end
end
