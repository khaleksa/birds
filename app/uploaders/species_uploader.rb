# encoding: utf-8

class SpeciesUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [1024, 768]
  process :quality => 80

  # Create different versions of your uploaded files:
  version :small do
    process :resize_to_fill => [700, 524]
  end

  version :thumb do
    process :resize_to_fill => [154, 116]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end
end
