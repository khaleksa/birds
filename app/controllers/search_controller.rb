class SearchController < ApplicationController

  def index

  end

  def search
    return if params[:text].blank?
    @species = Species.by_name(sanitize_text(params[:text])).order(:name_ru).all
    respond_to do |format|
      format.js
    end
  end

  def search_main_species
    return if params[:text].blank?
    @species = Species.by_name(sanitize_text(params[:text])).main.order(:name_ru).all
    respond_to do |format|
      format.js
    end
  end

  private
  def sanitize_text(text)
    '%' + text.to_s.downcase + '%'
  end
end
