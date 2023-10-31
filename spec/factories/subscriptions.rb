FactoryBot.define do
  factory :subscription do
    title { Faker::TvShows::Simpsons.quotes }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { Faker::Subscription.status }
    frequency { Faker::Subscription.subscription_term } 

    association :customer
  end
end
