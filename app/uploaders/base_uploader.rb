# encoding: utf-8

class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{salted_reproducible_id}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

  # ENV['CARRIERWAVE_SALT'] = nil on prod server (DigitalOcean)
  def salted_reproducible_id
    secret = [salt, model.id].join('/')
    Digest::SHA256.hexdigest(secret)
  end

  def salt
    # add some salt :)
    return nil
  end
end