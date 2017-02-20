require 'statistics/big_year'

class PagesController < ApplicationController
  PHOTO_COUNT_PER_PAGE = 8
  COMMENT_MAX_LENGTH = 64

  before_action :get_birds, only: [:index, :show_new]
  before_action :get_commentable_birds, only: [:index, :show_commentable]
  before_action :get_unknown_birds, only: [:index, :show_unknown]

  def index
  end

  def show_new
  end

  def show_commentable
  end

  def show_unknown
  end

  def approve
    @birds = Bird.published.known.unconfirmed.no_hybrid.order(created_at: :desc)
  end

  def about
    @users_count = User.count
    @species_count = Statistics::Counts.total_users_species_amount
    @birds_count = Bird.count
  end

  def birding_rules
  end

  def help
  end

  private
  def get_birds
    @birds = Bird.published.known.order(created_at: :desc).page(params[:new_page]).per(PHOTO_COUNT_PER_PAGE)
  end

  def get_commentable_birds
    @commented_birds = Bird.published.commentable_feed.page(params[:comment_page]).per(PHOTO_COUNT_PER_PAGE)
  end

  def get_unknown_birds
    @unknown_birds = Bird.published.unknown.order(created_at: :desc).page(params[:unknown_page]).per(PHOTO_COUNT_PER_PAGE)
  end
end
