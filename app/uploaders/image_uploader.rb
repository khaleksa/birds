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

  def extension_white_list
    %w(jpg jpeg png)
  end
end
