# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id         :bigint           not null, primary key
#  content    :text
#  due_date   :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#
# Indexes
#
#  index_assignments_on_course_id  (course_id)
#
class Assignment < ApplicationRecord
  belongs_to :course
  has_many :submissions

  validates :title, presence: true
  validates :content, presence: true
  validates :course_id, presence: true
  validates :due_date, presence: true
end
