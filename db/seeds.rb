require 'ffaker'
require 'factory_girl_rails'

namespace :db do
  Page.destroy_all

  Locale::ALL.each do |locale|
    6.times do
      parent_page = FactoryGirl.create :parent_page, locale: locale
      4.times do
        FactoryGirl.create :child_page, locale: locale, parent_page: parent_page
      end
    end
  end
end
