source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bundler', '>= 1.16.3'
gem 'rails', '5.1'

gem 'pg', '~> 0.20.0'

gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem "haml-rails"
gem 'turbolinks'

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'

gem 'activeadmin', git: 'git@github.com:activeadmin/activeadmin.git', branch: '1-4-stable'
gem 'devise', '>= 4.7.1'
gem 'omniauth'
gem 'omniauth-facebook', '>= 4.0.0'
gem 'recaptcha', :require => 'recaptcha/rails'

gem 'seed-fu', git: 'https://github.com/mbleigh/seed-fu'
gem 'seedbank'

gem 'closure_tree'
gem 'carrierwave'
gem 'mini_magick'

gem 'best_in_place'
gem 'kaminari'

gem 'choices'
gem 'bugsnag'

group :test, :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'factory_girl_rspec'

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