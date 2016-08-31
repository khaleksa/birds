class ContestsController < ApplicationController

  FILE_PATH = File.join(Rails.root, "public", "data")

  def big_day_in_ecocenter
  end

  def big_day_in_tashkent
  end

  def big_day_photo
  end

  def big_day_photo_species
  end

  def big_day_photo_form
    send_file(File.join(FILE_PATH, "photo_big_day_form.docx"))
  end

  def big_day_photo_rules
    send_file(File.join(FILE_PATH, "photo_big_day_rules.doc"))
  end

  def our_friend
  end

  def best_photo
  end

  def best_photo_file
    send_file(File.join(FILE_PATH, "Best_photo_form.docx"))
  end

  def winter_bird_watch
  end

  def big_year_result
  end

  def big_year_species
    @species_list = []
    Categories::Order.all.order(:position).each do |order|
      Categories::Family.where(parent_id: order.id).order(:position).each do |family|
        species = Species.joins(birds: :user)
                      .where("(birds.published = 'true') AND (birds.species_id IS NOT NULL) AND (birds.expert_id IS NOT NULL)")
                      .where(users: { :big_year => 'true' })
                      .where('EXTRACT(year FROM birds.timestamp) = ?', 2015)
                      .where('EXTRACT(year FROM birds.created_at) = ?', 2015)
                      .where(category_id: family.id)
                      .distinct('species.id')
                      .order(:position)
        @species_list = @species_list + species
      end
    end
  end

  def past
  end

  def shorebird_day
  end
end
