FactoryGirl.define do
  factory :apartment do
    title 'MyString'
    price '9.99'
    description 'MyText'
  end

  factory :admin_user do
    email 'admin@example.com'
    password 'password'
    password_confirmation 'password'
  end
end