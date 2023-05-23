# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    student { create(:student) }
    course { create(:course) }
  end
end
