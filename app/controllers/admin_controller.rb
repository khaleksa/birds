class AdminController < ApplicationController
  before_filter :authenticate_user!

  def become
    sign_in(:user, User.find(params[:id])) if current_user.has_role?(:owner)
    redirect_to :root
  end
end
