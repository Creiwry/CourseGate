# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ForumPost, type: :model do
  let(:forum_post) { build(:forum_post) }

  it 'is valid with valid attributes' do
    expect(forum_post).to be_valid
  end

  it 'is not valid without content' do
    forum_post.content = nil
    expect(forum_post).to_not be_valid
  end

  it 'belongs to a forum thread' do
    expect(forum_post.forum_thread).to be_instance_of(ForumThread)
  end

  it 'belongs to a student' do
    expect(forum_post.student).to be_instance_of(Student)
  end
end
