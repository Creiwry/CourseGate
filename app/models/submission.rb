# frozen_string_literal: true

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
