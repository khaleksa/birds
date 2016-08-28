class PagesController < ApplicationController

  PHOTO_COUNT_PER_PAGE = 8
  COMMENT_MAX_LENGTH = 64

  def index
    @birds = Bird.published.known.order(created_at: :desc).page(params[:new_page]).per(PHOTO_COUNT_PER_PAGE)
    @commented_birds = Bird.commentable_feed.page(params[:comment_page]).per(PHOTO_COUNT_PER_PAGE)
    @unknown_birds = Bird.published.unknown.order(created_at: :desc).page(params[:unknown_page]).per(PHOTO_COUNT_PER_PAGE)
    @user_list = Stats::Counts.new.big_year_users_species_count(2015)

    offset = params[:count]
    @birds = @birds.offset(offset.to_i) if offset
    @total_count = @birds.size + offset.to_i
  end

  def show_new
    @birds = Bird.published.known.order(created_at: :desc).page(params[:new_page]).per(PHOTO_COUNT_PER_PAGE)
  end

  def show_commentable
    @commented_birds = Bird.commentable_feed.page(params[:comment_page]).per(PHOTO_COUNT_PER_PAGE)
  end

  def show_unknown
    @unknown_birds = Bird.published.unknown.order(created_at: :desc).page(params[:unknown_page]).per(PHOTO_COUNT_PER_PAGE)
  end

  def big_year
    @stat = Stats::Counts.new
    @user_list = @stat.big_year_users_species_count
    @species_list = @stat.big_year_species
  end

  def approve
    @birds = Bird.published.known.unconfirmed.order(created_at: :desc)
  end

  def about
    @users_count = User.count
    @species_count = Stats::Counts.new.total_seen_species_count
    @birds_count = Bird.count
  end

  def birding_rules

  end

  def help
    
  end
end
