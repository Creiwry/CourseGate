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
class Submission < ApplicationRecord
  belongs_to :enrollment
  belongs_to :assignment
  after_initialize :init

  validates :enrollment, presence: true
  validates :assignment, presence: true

  def init
    self.score ||= 0.0
  end
end
