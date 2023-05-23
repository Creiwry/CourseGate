# frozen_string_literal: true

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
