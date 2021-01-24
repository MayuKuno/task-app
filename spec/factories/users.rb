FactoryBot.define do
  factory :user do
    username { 'テストユーザー1' }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end