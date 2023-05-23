# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :student_id, presence: true
  validates :course_id, presence: true
  validates_uniqueness_of :student_id, scope: :course_id
end
