FactoryBot.define do
  factory :favorite do
    country { Faker::Address.country  }
    recipe_link { Faker::Internet.url   }
    recipe_title { Faker::Food.dish }
    api_key { Faker::Number.number(digits: 16) }
  end
end
