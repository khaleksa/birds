require 'carrier_wave/mini_magick'

# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/google'
#   config.fog_credentials = {
#       provider: 'Google',
#       google_project: ENV['GC_BIRDS_PROJECT_ID'],
#       google_json_key_location: ENV['GC_BIRDS_CRED_FILE_PATH']
#   }
#   config.fog_directory = ENV['GC_BIRDS_IMAGE_BUCKET_ID']
# end

CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
      provider: 'Google',
      google_project: 'sonorous-mix-245813',
      google_json_key_location: 'config/google_cred.json'
  }
  config.fog_directory = 'birdsuzb_images'
end