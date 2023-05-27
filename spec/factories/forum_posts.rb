# frozen_string_literal: true

# == Schema Information
#
# Table name: forum_posts
#
#  id              :bigint           not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forum_thread_id :integer
#  student_id      :integer
#
# Indexes
#
#  index_forum_posts_on_forum_thread_id  (forum_thread_id)
#  index_forum_posts_on_student_id       (student_id)
#
FactoryBot.define do
  factory :forum_post do
    forum_thread
    student
    content { Faker::Lorem.paragraph }
  end
end
