# encoding: utf-8

class SpeciesUploader < BaseUploader
  process :resize_to_fill => [1024, 768]
  process :quality => 80

  version :small do
    process :resize_to_fill => [700, 524]
  end

  version :thumb do
    process :resize_to_fill => [154, 116]
  end

  def store_dir
    gcp_bucket_dir = Rails.configuration.carrierwave.gcp_store.dir
    "#{gcp_bucket_dir}/species/#{mounted_as}/#{salted_reproducible_id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
