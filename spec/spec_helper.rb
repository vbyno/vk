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
require 'ffaker'
require 'factory_girl_rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # config.color_enabled = true
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # http://stackoverflow.com/questions/6296235/undefined-method-get-for-rspeccoreexamplegroupnested-10x00000106db51f
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL
  config.include Warden::Test::Helpers
  config.include Rails.application.routes.url_helpers

  if defined?(CarrierWave)
    #make sure our base uploaders are loaded b/f we do this
    BasicImageUploader; PhotoUploader; PictureUploader

    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  config.before do
    I18n.locale = Locale::DEFAULT
  end

  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end
end