require File.expand_path('../boot', __FILE__)
require 'rails/all'
# https://github.com/magnusvk/counter_culture/issues/87
ActiveRecord::Base.raise_in_transactional_callbacks = true
Bundler.require(:default, Rails.env)

module Vk
  class Application < Rails::Application
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :ru
    config.show_i18n_errors = true

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
