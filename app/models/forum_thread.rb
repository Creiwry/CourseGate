# frozen_string_literal: true

class ForumThread < ApplicationRecord
  belongs_to :course
  has_many :forum_posts

  validates :title, presence: true
end
