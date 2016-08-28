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
    @timetamp = @bird.timestamp ||
                current_user.birds.where('timestamp IS NOT NULL').order(created_at: :desc).limit(1).pluck(:timestamp).first ||
                Time.zone.now
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
      hashtag = 'current'
    else
      hashtag = 'unknown'
    end

    return redirect_to root_path(anchor: hashtag)
  end

  def destroy
    bird = Bird.find(params[:id])
    bird_published = bird.published
    Bird.destroy(bird.id)
    birds_count = bird_published ? current_user.birds.published.count : current_user.birds.unpublished.count
    render json: { published: bird_published, count: birds_count }
  end

  def approve
    bird = Bird.find(params[:id]) if current_user.expert?
    result = bird.present? ? bird.update(expert_id: current_user.id) : false
    render json: { success: result }
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
