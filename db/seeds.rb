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

    FactoryGirl.create :main_page, locale: locale, permalink: locale
  end

  Admin.first_or_create(email: Figaro.env.admin_email) do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
end
