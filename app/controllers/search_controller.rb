class SearchController < ApplicationController

  def index

  end

  def search
    if params[:text].present?
      search_text = '%' + params[:text].to_s.downcase + '%'
      @species = Species
                   .where("(lower(name_ru) like ?) OR (lower(name_en) like ?) OR (lower(name_lat) like ?) OR (lower(name_uz) like ?)", search_text, search_text, search_text, search_text)
                   .order(:name_ru).all
    end

    respond_to do |format|
      format.js
    end
  end
end
