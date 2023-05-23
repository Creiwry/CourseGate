# frozen_string_literal: true

FactoryBot.define do
  factory :material do
    course
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
