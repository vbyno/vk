FactoryGirl.define do
  factory :apartment do
    sequence(:title) { |n| "Apartment #{n} Title" }
    sequence(:price) { |n| 100.99 + n }
    description 'Apartment Description'
    sequence(:short_description) { |n| "Apartment #{n} Short Description" }
    active false

    trait :active_with_main_image do
      after(:build) do |apartment|
        main_image = FactoryGirl.build(:gallery_image, apartment: apartment)
        active = true
      end

      after(:create) do |apartment|
        main_image = FactoryGirl.create(:gallery_image, apartment: apartment)
        active = true
      end
    end

    trait :with_translations do
      after(:build) do |apartment|
        translations = ApartmentTranslation::LOCALES.map { |locale|
          FactoryGirl.build(:apartment_translation,
                            locale: locale,
                            apartment: apartment)
        }
      end

      after(:create) do |apartment|
        translations = ApartmentTranslation::LOCALES.map { |locale|
          FactoryGirl.create(:apartment_translation,
                             locale: locale,
                             apartment: apartment)
        }
      end
    end
  end

  factory :gallery_image do
    image { File.new("#{Rails.root}/spec/support/images/main_image.jpg") }
    association :apartment
  end

  factory :apartment_translation do
    association :apartment
    title 'Translated Title'
    description 'Translated Description'
    sequence(:short_description) { |n| "Translated Apartment #{n} Short Description" }
    locale 'en'
  end

  factory :admin_user do
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