# frozen_string_literal: true

FactoryBot.define do
  factory :forum_thread do
    course
    title { Faker::Lorem.sentence }
  end
end
