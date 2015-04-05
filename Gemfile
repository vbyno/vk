source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'turbolinks'

gem 'devise'
gem 'cancan'
gem 'mini_magick'
gem 'carrierwave'
gem 'figaro'

gem 'resque'
gem 'resque-scheduler'
gem 'resque_mailer'
gem 'foreman', require: false

gem 'haml-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'simple-navigation'
gem 'sanitize'
gem 'bootstrap-sass'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'bootstrap-datepicker-rails'
gem 'tinymce-rails'
gem 'sass-rails'
gem 'font-awesome-rails'
gem 'jquery-fileupload-rails'

gem 'jbuilder'
gem 'uglifier'
gem 'rails-i18n'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'quiet_assets'
  gem 'annotate'
  gem 'newrelic_rpm'
  gem 'mailcatcher'

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
end

group :development, :test do
  gem 'thin'
  gem 'database_cleaner'
  gem 'pry-rails'

  # we need ffaker and factory for seeds
  gem 'ffaker', require: false
  gem 'factory_girl_rails', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'

  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara'

  gem 'simplecov', require: false
  gem 'fuubar'
end
