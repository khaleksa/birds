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

  def past
  end
end
