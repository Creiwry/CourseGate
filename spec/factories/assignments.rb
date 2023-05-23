# frozen_string_literal: true

FactoryBot.define do
  factory :assignment do
    course { create(:course) }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    due_date { Faker::Time.forward(days: 7) }
  end
end
