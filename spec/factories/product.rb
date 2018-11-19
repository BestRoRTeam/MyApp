FactoryBot.define do
  factory :product do
    name { Faker::Fallout.character }
    category { Faker::Fallout.faction }
    shop { Faker::Fallout.character }
    price { Random.rand(1..9) }
    quantity { Random.rand(1..9) }
    user_id { -1 }
  end
end
