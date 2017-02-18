require 'statistics/counts'

class UsersController < Devise::RegistrationsController
  before_filter :only => [:change_password, :unregister] do
    authenticate_user!(force: true)
  end
  before_filter :configure_permitted_parameters, :only => [:create]

  def index
    @users = Statistics::Counts.users_birds
    @big_year_users_count = Stats::Counts.new.big_year_users_count
  end

  def create
    super do |user|
      user.subscribe!(Time.zone.now.year) if user.big_year
    end
  end

  def change_password
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render 'profiles/show'
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :big_year
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
