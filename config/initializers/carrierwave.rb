# TODO: separate in 2 files
CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
      provider: 'Google',
      google_project: 'sonorous-mix-245813',
      google_json_key_location: '/Users/alexandra/XProject/birds/birds/google_cred.json'
  }
  config.fog_directory = 'birdsuzb_images'
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
