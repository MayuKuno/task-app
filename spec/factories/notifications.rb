FactoryBot.define do
  factory :notification do
    user { nil }
    task { nil }
    action { 1 }
    checked { false }
  end
end
