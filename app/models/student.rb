# frozen_string_literal: true

class Student < ApplicationRecord
  has_secure_password
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :forum_posts

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
