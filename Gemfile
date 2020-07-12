source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bundler', '= 1.17.1'
gem 'rails', '5.1'

gem 'pg', '~> 0.20.0'

gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin', branch: '1-4-stable'
gem 'best_in_place'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'bugsnag'
gem 'carrierwave'
gem 'choices'
gem 'closure_tree'
gem 'devise', '>= 4.7.1'
gem 'globalize'
gem 'globalize-accessors'
gem 'jquery-rails'
gem "haml-rails"
gem 'kaminari'
gem 'mini_magick'
gem 'momentjs-rails', '>= 2.9.0'
gem 'omniauth'
gem 'omniauth-facebook', '>= 4.0.0'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'sass-rails'
gem 'seed-fu', git: 'https://github.com/mbleigh/seed-fu'
gem 'seedbank'

gem 'closure_tree'
gem 'carrierwave'
gem 'mini_magick'


group :test, :development do
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'factory_girl_rspec'

  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
end

group :development do
  gem 'capistrano', '3.6.1', require: false
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rvm'
end

group :deploy do
  # remember to update deploy.rb
  gem 'bcrypt_pbkdf'
  gem 'ed25519'
end