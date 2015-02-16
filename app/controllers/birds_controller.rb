#TODO: rewrite, use ajax
class BirdsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :new]

  DATE_FORMAT = ''

  def show
    bird_id = params[:id]
    @bird = Bird.find(bird_id)
    @comments = Comment.bird_comments(bird_id)
  end

  def new
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
    binding.pry
    @bird = Bird.find(params[:id])
    @species = Species.all.order(:name_ru)
  end

  def update
    binding.pry
    @bird = Bird.find(params[:id])

    respond_to do |format|
      binding.pry
      if @bird.update_attributes(bird_params(params))
        binding.pry
        format.html do
          redirect_to action: next_edit_action(@bird), id: @bird.id
          # redirect_to action: :edit, id: @bird.id
        end
        format.js   {}
        format.json { render json: @bird, status: :accepted, location: @bird }
      else
        binding.pry
        format.html {redirect_to action: :edit, id: @bird.id}
        format.json { render json: @bird.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish

    redirect_to :root
  end

  private
  #TODO: add species
  def bird_params(params)
    params.require(:bird).permit(:photo, :photo_cache, :timestamp, :latitude, :longitude, :address)
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
