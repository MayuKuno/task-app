FactoryBot.define do
  factory :user do
    username { 'ユーザーA' }
    sequence(:email) { 'a@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end