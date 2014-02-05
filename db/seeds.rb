require 'ffaker'
require 'factory_girl_rails'

namespace :db do
  Page.destroy_all

  Locale::ALL.each do |locale|
    2.times { FactoryGirl.create :child_page, locale: locale }
  end
end
