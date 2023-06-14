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
class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course
  has_many :submissions

  validates :student_id, presence: true
  validates :course_id, presence: true
  validates_uniqueness_of :student_id, scope: :course_id
end
