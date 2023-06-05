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
require 'spec_helper'

RSpec.describe ForumThread, type: :model do
  let(:forum_thread) { build(:forum_thread) }

  it 'is valid with valid attributes' do
    expect(forum_thread).to be_valid
  end

  it 'is not valid without a title' do
    forum_thread.title = nil
    expect(forum_thread).to_not be_valid
  end

  it 'belongs to a course' do
    expect(forum_thread.course).to be_instance_of(Course)
  end

  it 'has many forum posts' do
    forum_thread.save
    forum_post1 = create(:forum_post, forum_thread:)
    forum_post2 = create(:forum_post, forum_thread:)
    expect(forum_thread.forum_posts.count).to eq(2)
    expect(forum_thread.forum_posts).to match_array([forum_post1, forum_post2])
  end
end
