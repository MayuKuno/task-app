FactoryBot.define do
  factory :task do
    taskname { 'rubyの勉強をする' }
    description { 'ドットインストールで講座を受ける'}
    association :user
  end
end