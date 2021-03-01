FactoryBot.define do
  factory :user do
    username { 'テストユーザー' }
    sequence(:email) { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
