FactoryGirl.define do
  factory :apartment do
    sequence(:title) { |n| "Apartment #{n} Title" }
    sequence(:price) { |n| 100.99 + n }
    sequence(:description) { |n| "Apartment #{n} Description" }

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

  factory :apartment_translation do
    association :apartment
    title 'Translated Title'
    description 'Translated Description'
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