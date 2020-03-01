# encoding: utf-8

class AvatarUploader < BaseUploader
  process :resize_to_fill => [128, 128]

  version :thumb do
    process :resize_to_fit => [36,36]
  end

  def default_url
    ActionController::Base.helpers.asset_path("profile/" + [version_name, "profile_empty.png"].compact.join('_'))
  end
end