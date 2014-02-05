require 'ffaker'
require 'factory_girl_rails'

namespace :db do
  Page.destroy_all

  Locale::ALL.each do |locale|
    2.times do
      parent_page = FactoryGirl.create :parent_page, locale: locale
      FactoryGirl.create :child_page, locale: locale, parent_page: parent_page
    end
  end
end
