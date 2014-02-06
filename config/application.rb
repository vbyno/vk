require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(:default, Rails.env)

module Vk
  class Application < Rails::Application
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :ru

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.generators do |g|
      g.test_framework :rspec,
                       controller_specs: true,
                       request_specs: true,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
