FactoryBot.define do
  factory :feedback do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    text { Faker::Lorem.paragraph }

    trait :invalid do
      name { nil }
    end
  end
end
