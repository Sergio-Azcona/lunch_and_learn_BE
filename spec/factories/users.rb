FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    api_key { Faker::Number.number(digits: 16) }
  end
end