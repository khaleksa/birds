class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :filter_users

  BLACK_EMAILS = %w(mavlonov_83@mail.ru)

  def create
    if params[:comment].blank? || params[:bird].blank?
      render json: { success: false }
      return
    end

    comment = Comment.new(text: sanitize_url(params[:comment]))
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

  private
  def sanitize_url(text)
    text.gsub(/(http?:\/\/birds.uz[\S]*)/, '<a href="\1">\1</a>')
  end

  def filter_users
    return render json: { success: false } if current_user.try(:restricted?)
  end
end
