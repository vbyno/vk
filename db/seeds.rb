require 'ffaker'
require 'factory_girl_rails'

def create_admin_if_needed!
  Admin.first_or_create(email: Figaro.env.admin_email) do |admin|
    admin.password = Figaro.env.admin_password
    admin.password_confirmation = Figaro.env.admin_password
  end
end

def create_pages!
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
end

namespace :db do
  create_admin_if_needed!
  create_pages!
end
