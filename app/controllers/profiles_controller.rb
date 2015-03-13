class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])

    stat = Stats::Counts.new
    @big_year_species_count = stat.big_year_user_species_count(@user.id, Time.zone.now.year)
    @big_year_rating = stat.big_year_user_rating(@user.id)
    @species = stat.user_species(@user.id)

    @birds = Bird.includes(:species).where(user_id: @user.id).order(timestamp: :desc)
    @comments = Comment.where(user_id: @user.id).order(created_at: :desc)
  end
  
  def update
    current_user.update_attributes editable_params

    respond_to do |format|
      format.html { redirect_to  action: :show }
      format.json { respond_with_bip current_user }
    end
  end

  def subscribe
    render
  end

  private
  def editable_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :big_year)
  end
end
