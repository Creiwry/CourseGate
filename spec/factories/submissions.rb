# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    assignment { create(:assignment) }
    enrollment { create(:enrollment) }
    content { Faker::Lorem.paragraph }
  end
end
