class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    stat = Stats::Counts.new
    @species_count = stat.big_year_user_species_count(@user.id, Time.zone.now.year)
    @rating = stat.big_year_user_rating(@user.id)
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
