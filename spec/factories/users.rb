FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }

    trait :admin_user do
      admin { true }
    end
  end
end
