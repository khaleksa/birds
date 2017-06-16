Recaptcha.configure do |config|
  config.site_key  = Rails.configuration.recaptcha.public_key
  config.secret_key = Rails.configuration.recaptcha.private_key
end
