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

  #TODO: is it safe???
  def destroy
    Comment.destroy(params[:id])
    render json: { success: true }
  end
end
