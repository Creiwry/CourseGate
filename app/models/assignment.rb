# frozen_string_literal: true

class Assignment < ApplicationRecord
  belongs_to :course
  has_many :submissions

  validates :title, presence: true
  validates :content, presence: true
  validates :course_id, presence: true
  validates :due_date, presence: true
end
