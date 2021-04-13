FactoryBot.define do
  factory :task do
    taskname { 'rubyの勉強をする' }
    description { 'ドットインストールを受ける'}
    priority { :low }
    status { :Waiting }
    deadline { 1.week.from_now }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :user

    trait :due_yesterday do
      deadline 1.day.ago
    end

    trait :due_today do
      deadline Date.current.in_time_zone
    end

    trait :due_tomorrow do
      deadline 1.day.from_now
    end

  end
end


