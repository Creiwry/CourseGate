# frozen_string_literal: true

class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :student

  validates :content, presence: true
end
