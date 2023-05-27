# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_enrollments_on_course_id   (course_id)
#  index_enrollments_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (student_id => students.id)
#
FactoryBot.define do
  factory :enrollment do
    student { create(:student) }
    course { create(:course) }
  end
end
