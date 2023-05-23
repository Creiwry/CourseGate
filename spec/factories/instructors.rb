# frozen_string_literal: true

FactoryBot.define do
  factory :instructor do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { 'password' }
    bio { Faker::Lorem.paragraph }
  end
end
