class SearchController < ApplicationController

  def index

  end

  def search
    return if params[:text].blank?
    @species = species_by_name
    respond_to do |format|
      format.js
    end
  end

  def search_main_species
    return if params[:text].blank?
    @species = species_by_name(true)
    respond_to do |format|
      format.js
    end
  end
  
  private
  def species_by_name(only_main = false)
    @species = Species
                .with_translations([I18n.available_locales])
                .where("lower(species_translations.name) LIKE :name", name: sanitize_text(params[:text]))
    @species = @species.main if only_main
    @species
  end

  def sanitize_text(text)
    '%' + text.mb_chars.downcase.to_s + '%'
  end
end
