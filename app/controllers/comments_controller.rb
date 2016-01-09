class CommentsController < ApplicationController
  before_action :authenticate_user!

  BLACK_EMAILS = %w(mavlonov_83@mail.ru)

  def create
    if params[:comment].blank? || params[:bird].blank?
      render json: { success: false }
      return
    end

    comment = Comment.new(text: params[:comment])
    comment.user = current_user
    comment.bird_id = params[:bird].to_i
    comment.save

    render json: { success: comment.persisted? }
  end

  def destroy
    unless BLACK_EMAILS.include?(current_user.email)
      Comment.destroy(params[:id])
    end
    render json: { count: current_user.comments.size }
  end
end
