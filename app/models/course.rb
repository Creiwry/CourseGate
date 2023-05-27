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
class Course < ApplicationRecord
  belongs_to :instructor
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :materials
  has_many :assignments
  has_many :forum_threads

  validates :name, presence: true
  validates :instructor, presence: true
end
