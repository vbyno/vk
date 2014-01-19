FactoryGirl.define do
  factory :apartment do
    sequence(:title) { |n| "Apartment #{n} Title" }
    sequence(:price) { |n| 100.99 + n }
    description 'Apartment Description'
    sequence(:short_description) { |n| "Apartment #{n} Short Description" }
    active false

    trait :active_with_main_photo do
      after :build do |apartment|
        apartment.main_photo = build :photo, apartment: apartment
        apartment.active = true
      end

      after :create do |apartment|
        apartment.main_photo.save!
        apartment.save!
      end
    end

    trait :with_translations do
      after :build do |apartment|
        apartment.translations = ApartmentTranslation::LOCALES.map { |locale|
          build(:apartment_translation, locale: locale, apartment: apartment)
        }
      end

      after :create do |apartment|
        apartment.translations.each(&:save!)
      end
    end
  end

  factory :photo do
    image { File.new("#{Rails.root}/spec/support/images/main_photo.jpg") }
    association :apartment
  end

  factory :apartment_translation do
    association :apartment
    title 'Translated Title'
    description 'Translated Description'
    sequence(:short_description) { |n| "Translated Apartment #{n} Short Description" }
    locale 'en'
  end

  factory :reservation do
    association :apartment
    customer_name 'Customer Name'
    customer_email 'customer@email.comx'
    check_in { DateTime.tomorrow + 12.hours }
    check_out { DateTime.tomorrow + 1.day + 11.hours }
    status Reservation::PENDING
  end

  factory :admin do
    email 'admin@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
