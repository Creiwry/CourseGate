# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id            :bigint           not null, primary key
#  content       :text
#  score         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignment_id :integer
#  enrollment_id :integer
#
# Indexes
#
#  index_submissions_on_assignment_id  (assignment_id)
#  index_submissions_on_enrollment_id  (enrollment_id)
#
FactoryBot.define do
  factory :submission do
    assignment { create(:assignment) }
    enrollment { create(:enrollment) }
    content { Faker::Lorem.paragraph }
  end
end
