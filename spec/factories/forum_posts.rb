# frozen_string_literal: true

FactoryBot.define do
  factory :forum_post do
    forum_thread
    student
    content { Faker::Lorem.paragraph }
  end
end
