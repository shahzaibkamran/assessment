require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "zebkam67@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    confirmed_at { Time.now }
    role { 0 } 
    admin { false } 
    trait :admin do
      role { 1 } 
      admin { true } 
    end
  end
end

FactoryBot.define do
    factory :topic do
      category { Faker::Lorem.word } 
    end
end

FactoryBot.define do
    factory :author do
      name { Faker::Name.name } 
    end
end
  
FactoryBot.define do
    factory :article do
      title { Faker::Lorem.sentence } 
      content { Faker::Lorem.paragraph } 
      description { Faker::Lorem.sentence } 
      url { Faker::Internet.url } 
      urlToImage { Faker::Internet.url }
      publishedAt { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) } # generate a random publishedAt datetime
      topic { build(:topic) }
      author { build(:author) }
    end
end