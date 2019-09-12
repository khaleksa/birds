class UsersController < Devise::RegistrationsController
  before_action :only => [:change_password, :unregister] do
    authenticate_user!(force: true)
  end
  before_action :configure_permitted_parameters, :only => [:create]

  #TODO!!!:: remove to separate controller!!
  def index
    @users = Statistics::Counts.users_birds
    @big_year_users_count = Statistics::BigYear.users_count
  end

  def create
    if verify_recaptcha
      super do |user|
        user.subscribe!(Time.zone.now.year) if user.big_year
      end
    else
      render 'new'
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :big_year])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
