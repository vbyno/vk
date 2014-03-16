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
        apartment.translations = Locale::SECONDARY.map { |locale|
          build(:apartment_translation, locale: locale, apartment: apartment)
        }
      end

      after :create do |apartment|
        apartment.translations.each(&:save!)
      end
    end

    trait :pure do
    end
  end

  factory :picture do
    association :imageable, factory: :parent_page
    image { File.new("#{Rails.root}/spec/support/images/main_photo.jpg") }
  end

  factory :photo do
    association :apartment
    image { File.new("#{Rails.root}/spec/support/images/main_photo.jpg") }
  end

  factory :photo_translation do
    association :photo

    trait :rich do
      alt 'Translated Photo Alt'
      title 'Translated Photo Title'
    end

    trait :pure do
      photo nil
    end
  end

  factory :apartment_translation do
    association :apartment
    title 'Translated Title'
    description 'Translated Description'
    sequence(:short_description) { |n|
      "Translated Apartment #{n} Short Description"
    }
    locale 'en'

    trait :pure do
      apartment nil
    end
  end

  factory :reservation do
    association :apartment
    customer_name 'Customer Name'
    customer_email 'customer@email.comx'
    customer_phone '380673003030'
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

  factory :page, class: Page do
    sequence(:permalink) { |n| "page_#{n}" }
    sequence(:title) { |n| "Page #{n} Title" }
    intro 'Short intro for page'
    locale 'ru'
    content { "<p>#{Faker::Lorem.paragraph}</p>" }
    seo_title 'Seo Title'
    priority 0
    active true

    factory :parent_page, class: ParentPage do
      sequence(:title) { |n| "Parent Page #{n} Title" }
      sequence(:permalink) { |n| "parent_#{n}" }
    end

    factory :child_page, class: ChildPage do
      association :parent_page
      sequence(:title) { |n| "Child Page #{n} Title" }
      sequence(:permalink) { |n| "child_#{n}" }
    end
  end
end
