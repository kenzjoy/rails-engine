FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Commerce.price(range: 1.0..50.0) }
    merchant
  end
end
