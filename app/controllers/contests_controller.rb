class ContestsController < ApplicationController

  FILE_PATH = File.join(Rails.root, "public", "data")

  def big_day_in_ecocenter

  end

  def big_day_in_tashkent

  end

  def our_friend

  end

  def best_photo

  end

  def best_photo_file
    send_file(File.join(FILE_PATH, "Best_photo_form.docx"))
  end
end