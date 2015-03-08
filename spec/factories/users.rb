require 'ffaker'

FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      role 'admin'
    end
  end
end
