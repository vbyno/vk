def zeus_running?
  File.exists? '.zeus.sock'
end

unless zeus_running?
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV["RAILS_ENV"] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rubygems'
require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.color_enabled = true
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  config.include Capybara::DSL
  config.include Warden::Test::Helpers
end
