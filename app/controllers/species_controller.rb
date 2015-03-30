class SpeciesController < ApplicationController

  def index
  end

  def show
    species_id = params[:id]
    @species = Species.find(species_id)
    @default_image = @species.default_image
  end

  def map
    @species = Species.find(params[:species_id])
    @birds = Bird.by_species(@species.id).order(timestamp: :desc)
  end
end
