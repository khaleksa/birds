class UsersController < Devise::RegistrationsController
  before_filter :only => [:change_password, :unregister] do
    authenticate_user!(force: true)
  end
  before_filter :configure_permitted_parameters, :only => [:create]

  def index
    @users = User.includes(:birds).all
  end

  def create
    super

    # if omniauth_registration? || verify_recaptcha
    #   super do |user|10px
    #     session[:instruction] = true
    #     @tracking_manager.register(:registration, user)
    #   end
    # else
    #   build_resource(sign_up_params)
    #   clean_up_passwords(resource)
    #   flash.now[:alert] = I18n.t('signup.errors.recaptcha')
    #   flash.delete :recaptcha_error
    #   render :new
    # end
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
