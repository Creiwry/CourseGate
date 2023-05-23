# frozen_string_literal: true

class Material < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true
end
