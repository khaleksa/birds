class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])

    @big_year_species_count = Statistics::BigYear.user_species_count(@user.id, Time.zone.now.year)
    @big_year_rating = Statistics::BigYear.user_rating(@user.id)
    @species = Statistics::Counts.user_species(@user.id)

    #TODO: separate pagination of birds and comments
    @birds = Bird.includes(:species).published.by_user(@user.id).order(created_at: :desc).page(params[:page_birds]).per(18)
    @drafts = Bird.includes(:species).unpublished.by_user(@user.id).order(created_at: :desc)
    @comments = Comment.where(user_id: @user.id).order(created_at: :desc).page(params[:page_comments]).per(15)

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    current_user.update_attributes editable_params

    respond_to do |format|
      format.html { redirect_to  action: :show }
      format.json { respond_with_bip current_user }
    end
  end

  private
  def editable_params
    params.require(:user).permit(:avatar, :first_name, :last_name)
  end
end
