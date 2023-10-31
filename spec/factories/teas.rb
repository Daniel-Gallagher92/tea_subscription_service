FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.notes }
    temperature { Faker::Number.between(from: 150, to: 212 ).to_s + " degrees" }
    brew_time { Faker::Number.between(from: 1, to: 5 ).to_s + " minutes" }
  end
end
