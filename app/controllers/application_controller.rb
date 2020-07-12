class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def switch_locale
    locale = params[:locale].to_sym
    if I18n.available_locales.include?(locale)
      I18n.locale = locale
      cookies.permanent[:locale] = locale
      # current_user.update_attributes(locale: locale.to_s) if current_user
    end

    redirect_back(fallback_location: '/', allow_other_host: false)
  end

  private

  def set_locale
    I18n.locale = cookies.permanent[:locale] || I18n.default_locale
  end
end
