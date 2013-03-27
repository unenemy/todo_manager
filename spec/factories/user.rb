FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "111111"
    password_confirmation "111111"

    trait :sharer do
      email "sharer@example.com"
    end
  end
end
