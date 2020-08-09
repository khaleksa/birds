require 'carrier_wave/mini_magick'
require "base64"

puts "********************** RAILS_ENV = #{ENV['RAILS_ENV']} "
puts "********************** GCP_IMAGE_CREDS = #{ENV['GCP_IMAGE_CREDS']} "
puts "********************** BIRDS_CARRIERWAVE_SALT = #{ENV['BIRDS_CARRIERWAVE_SALT']} "
puts "********************** DATABASE_HOST = #{ENV['DATABASE_HOST']} "
puts "********************** DATABASE_USERNAME = #{ENV['DATABASE_USERNAME']} "
puts "********************** DATABASE_PASSWORD = #{ENV['DATABASE_PASSWORD']} "

# Working on production
# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/google'
#   config.fog_credentials = {
#     provider: 'Google',
#     google_project: 'birds-stage',
#     google_json_key_string: Base64.decode64(ENV['GCP_IMAGE_CREDS'])
#   }
#   config.fog_directory = 'birds-files/images_eu_w4'
# end

# Working for Dev env, doesn't work on prod
CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    google_project: 'birds-stage',
    google_json_key_string: ENV['RAILS_ENV']=='production' ? Base64.decode64(ENV['GCP_IMAGE_CREDS']) : ENV['GCP_IMAGE_CREDS']
  }
  config.fog_directory = 'birds-files/images_eu_w4'
end

# # !_WORKING CONF FOR birds-stage_ with cred file located locally!
# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/google'
#   config.fog_credentials = {
#       provider: 'Google',
#       google_project: 'birds-stage',
#       google_json_key_location: 'birds-stage-sa-images-key.json'
#   }
#   config.fog_directory = 'birds-files/images_eu_w4'
# end

# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/google'
#   config.fog_credentials = '{
#     provider: "Google",
#     google_project: "sonorous-mix-245813",
#     google_json_key_string: "{
#       "type": "service_account",
#       "project_id": "sonorous-mix-245813",
#       "private_key_id": "489ec25a9f315d91904be4a7c38e1a690f09d792",
#       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDLd0qzqK8mI0nF\nVMd1jzStH6HsFrol4TuMXqEDadFFplzcrZR1X9lulRk2EXA3U0Fs4YINW9ikAo1n\nMp97GxcZU/q+x+/Csi+UYzNuv4XXCwT7Yq5fbjgCFKBUIEub45Ps7AiGPKheq4qE\nxDatk4Pr1ZcvoEWhyMvFwzJ22izcYm4Vaqtl5HDNSY1+Ea7UlQp7driNvD/QQ8z9\nPFRipfWgJneCEp+r0cSSFWoHOzONkC0DHAVH5Ppktc3tnXYuhV3IER1r8SV9FKuj\nyUdyP/tcfh+tfmL4iCzKZ+2AaTde6HSKEZFVlGlMlVZJkhBwMvaBkTpVPlLfVRog\nTf/oXHevAgMBAAECggEAHEnf19PGVPycsfQZbpsJsrT5BoHwa/or6oEbojBbrsiJ\nv7WIibsuWBAgew0jTNCQAks7kY+UCCrsrbednHhF7A5qMzf0JLMxJ1CVjY/Q/sw4\nQJqrQ3cSZW5TDkSWjpGDzHHStkCHvkXbvUgp5qnhsm/gvyKURoFMR5jd6CVpuFLd\nnYEG4mpNH7BOsYzuzPpSJLjjc3o+PuEPDwcHl64ZeLMznZBscgicFPJcDAqLIzgX\nTdh3uZIwU7Zo9+Gtvj0wCnYI+IiYQPENUL4mRc5/yFV6eTKlrMncnKHypEV1KXm8\nFEUfFfnGvbNf4v6uExNWbXwhrdHacCVSVtHt9CLtdQKBgQDq/4foQfSQHyoH7kow\nu0Fi5IANfoKCWjHW2AR2lcbLR54QaCafa6TyocWSBGKK/qnJZJ/Qw7Glr7ATBM3I\n6IILuqrpmA/gp7onnt0cyEj/Uv2jTCVEk4a0TewO3vxr736syulfKMzevjJPQEvW\n0y5QeLoxixp6FdbYjUnWcOscAwKBgQDdplfj4ecwv1oo9W8aqaYqz/ts7Pxlou4L\nGiHTsbGHlyvTDgbvTRCJ88O7h6jnx4UJxG392eX8v4JjgrycVGK72IfyZXkKigyr\nnH9yV04r08kgiBtfmde5Sc69Dh9/NbLsx+mVvMRpcRqCzyhBNx+f6175Q3zQFQ2P\nvt2TIGgj5QKBgAuyWFNpJQEfa/olFDBEwcZoVS9Wwqw2TRDCg8ZbQh/QGr/6TyHU\nO8uP3cOc0ELW1iCeD45WjzsN+ZeYv51mZUKsMeGanf+ymYNrVtod5fQ/bzx3h8tY\nBHZpAnzjAHFm5Ek5eFAyObBEi0CClMPGkyGSQMJCiDjXaXAx6CDyUeF9AoGAU+tA\nCZKlQqqgSzOprjGfLURzkCkl4qFOeTuapRj4+zo8KHt+GqpV4bU+XUkepSrAbxNF\nBcCzN/+WMXD1UkcM3sw7pIXQzzG3XF4zTqpJeYSE+OEvZAHOUGPmd2PafwJozQdf\npAbFYpqlC/O87Pwe6CBoY/2uSuY9rTf5klPJuhUCgYEAsA4DuCqv3zE8RSuCsEfI\ne9cHi4NVtPajnP9nqk0us1DWa47t7yEd8yqF0yb9tgvjRhmUGH47mRawMxjomuqX\n4u+mkaHRLDTJSrxP++OM/5SUbkq9n8sV93LH/1dORVQXV2WaMK+9NwilCjImf8KA\neqRiWKxOA30FMrwZbsHK/jQ=\n-----END PRIVATE KEY-----\n",
#       "client_email": "images@sonorous-mix-245813.iam.gserviceaccount.com",
#       "client_id": "114038529759881497090",
#       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
#       "token_uri": "https://oauth2.googleapis.com/token",
#       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
#       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/images%40sonorous-mix-245813.iam.gserviceaccount.com"
#     }
#   }'
#   config.fog_directory = 'birdsuzb_images_eu_w1'
# end
