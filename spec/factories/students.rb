# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { 'password' }
  end
end
