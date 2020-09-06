# encoding: utf-8

class ImageUploader < BaseUploader
  process :resize_to_fill => [700, 524]
  process :quality => 80

  version :small do
    process :resize_to_fill => [256, 192]
  end

  version :thumb do
    process :resize_to_fill => [154, 116]
  end

  def store_dir
    gcp_bucket_dir = Rails.configuration.carrierwave.gcp_store.dir
    "#{gcp_bucket_dir}/bird/#{mounted_as}/#{salted_reproducible_id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  private

  def salt
    ENV['BIRDS_CARRIERWAVE_SALT']
  end
end

