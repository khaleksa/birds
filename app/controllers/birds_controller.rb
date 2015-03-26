#TODO: rewrite, use ajax
class BirdsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  layout 'map', only: [:edit_map, :show]

  def show
    @bird = Bird.find(params[:id])
  end

  def new
    @bird = Bird.new
  end

  def create
    permit_params = bird_params
    if permit_params[:photo].blank?
      redirect_to :back
      return
    end

    bird = Bird.new(permit_params)
    bird.user = current_user
    bird.save!

    if bird.persisted?
      redirect_to action: :edit_date, id: bird.id
    else
      redirect_to :back
    end
  end

  def edit_date
    @bird = Bird.find(params[:id])
  end

  def edit_map
    @bird = Bird.find(params[:id])
  end

  def edit_species
    @bird = Bird.find(params[:id])
    @families = Categories::Family.all.order(:position)
  end

  def update
    @bird = Bird.find(params[:id])

    respond_to do |format|
      if @bird.update_attributes(bird_params)
        format.html do
          redirect_to action: next_edit_action(@bird), id: @bird.id
        end

        format.js   {}
        format.json { render json: @bird, status: :accepted, location: @bird }
      else
        format.html { redirect_to action: :edit, id: @bird.id }
        format.json { render json: @bird.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @bird = Bird.find(params[:id])
    @bird.publish! if @bird.can_publish?

    species_id = params['bird-species-id'].to_i
    if species_id > 0
      @bird.update_attributes(species_id: species_id)
      return redirect_to :root
    else
      return redirect_to unknowns_pages_path
    end
  end

  #TODO: is it safe???
  def destroy
    Bird.destroy(params[:id])
    render json: { success: true }
  end

  private
  def bird_params
    params.require(:bird).permit(:photo, :photo_cache, :timestamp, :latitude, :longitude, :address, :species_id)
  end

  def next_edit_action(bird)
    if bird.timestamp.blank?
      return :edit_date
    elsif bird.latitude.blank? || bird.longitude.blank?
      return :edit_map
    else
      return :edit_species
    end
  end
end
