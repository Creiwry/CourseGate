# frozen_string_literal: true

class Instructor < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :courses
end
