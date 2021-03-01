FactoryBot.define do
  factory :user do
    username { 'テストユーザー' }
    sequence(:email) { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    username { "アドミン" }
    sequence(:email) { Faker::Internet.email }
    password { "adminpassword" }
    admin { true }
  end
end
