FactoryBot.define do
  factory :task do
    taskname { 'rubyの勉強をする' }
    description { 'ドットインストールを受ける'}
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :user
  end
end


