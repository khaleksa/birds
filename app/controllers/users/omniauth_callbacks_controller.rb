class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def all
    auth = auth_data
    user = User.from_omniauth(auth)
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
    else
      user = User.where(email: auth[:email]).first
      if user.present?
        sign_in_and_redirect user, event: :authentication
      else
        continue_signup(auth)
      end
    end
  end

  alias_method :facebook, :all

  private
  def auth_data
    result = {}
    omniauth = request.env['omniauth.auth']
    result[:social_accounts_attributes] = omniauth.slice(:uid, :provider)

    if omniauth[:provider].to_sym == :facebook
      result[:email] = omniauth['info']['email']
      result[:first_name] = omniauth['info']['first_name']
      result[:last_name] = omniauth['info']['last_name']
    end

    result
  end

  def continue_signup(auth_data)
    session['devise.user_attributes'] = auth_data
    redirect_to new_user_registration_url
  end
end
