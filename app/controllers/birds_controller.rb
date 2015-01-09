class BirdsController < ApplicationController

  def new
    binding.pry
    redirect_to new_user_session_path unless current_user
    @bird = Bird.new
  end

  def create
    binding.pry

    permit_params = bird_params(params)
    if permit_params[:photo].blank?
      redirect_to :back
      return
    end

    bird = Bird.new(permit_params)
    bird.user = current_user
    bird.save!

    if bird.persisted?
      redirect_to action: :edit, id: bird.id
    else
      redirect_to :back
    end
  end

  def edit
    binding.pry
    @bird = Bird.find(params[:id])
  end

  def update
    @bird = Bird.find(params[:id])

    respond_to do |format|
      binding.pry
      if @bird.update_attributes(bird_params(params))
        binding.pry
        format.html {redirect_to action: :edit, id: @bird.id}
        format.js   {}
        format.json { render json: @bird, status: :accepted, location: @bird }
      else
        binding.pry
        format.html {redirect_to action: :edit, id: @bird.id}
        format.json { render json: @bird.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  #TODO: add species
  def bird_params(params)
    params.require(:bird).permit(:photo, :photo_cache, :timestamp, :latitude, :longitude)
  end

end
