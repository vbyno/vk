# == Schema Information
#
# Table name: apartments
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  price             :decimal(6, 2)    not null
#  description       :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#  main_photo_id     :integer
#  active            :boolean          default(FALSE), not null
#  short_description :string(255)      default(""), not null
#  permalink         :string           not null
#

FactoryGirl.define do
  factory :apartment do
    sequence(:title) { |n| "Apartment #{n} Title" }
    sequence(:price) { |n| 100.99 + n }
    sequence(:permalink) { |n| "permalink_#{n}" }
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
end
