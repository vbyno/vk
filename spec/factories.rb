FactoryGirl.define do
  factory :apartment do
    title 'MyString'
    price '9.99'
    description 'MyText'
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