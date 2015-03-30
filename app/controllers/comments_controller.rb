class CommentsController < ApplicationController
  before_action :authenticate_user!

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
    deleted_comment = Comment.destroy(params[:id])
    render json: { success: deleted_comment.present? }
  end
end
