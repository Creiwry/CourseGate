# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  description   :text
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instructor_id :bigint           not null
#
# Indexes
#
#  index_courses_on_instructor_id  (instructor_id)
#
# Foreign Keys
#
#  fk_rails_...  (instructor_id => instructors.id)
#
FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    instructor
  end
end
