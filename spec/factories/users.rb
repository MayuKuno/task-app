FactoryBot.define do
  factory :user do
    username { 'テストユーザー' }
    sequence(:email) { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :admin_user, class: User do
    username { "admin_user" }
    sequence(:email) { Faker::Internet.email }
    password { "adminpassword" }
    admin {"true"}
  end
end
