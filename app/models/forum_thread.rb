# frozen_string_literal: true

# == Schema Information
#
# Table name: forum_threads
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#
# Indexes
#
#  index_forum_threads_on_course_id  (course_id)
#
class ForumThread < ApplicationRecord
  belongs_to :course
  has_many :forum_posts
  has_one :instructor, through: :course

  validates :title, presence: true
end
