FactoryGirl.define do
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

  factory :reservation do
    association :apartment
    customer_name 'Customer Name'
    customer_email 'customer@email.comx'
    customer_phone '380673003030'
    check_in { DateTime.tomorrow + 12.hours }
    check_out { DateTime.tomorrow + 1.day + 11.hours }
    status Reservation::PENDING
  end
end
