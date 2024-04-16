require 'rails_helper'

RSpec.describe "ForumPosts", type: :request do
  let(:forum_post) { create(:forum_post) }
  let(:forum_thread) { create(:forum_thread) }
  let(:student) { create(:student) }

  before do
    sign_in(student)
  end

  describe 'POST #create' do
    it 'creates a new forum post' do
      expect do
        post forum_thread_forum_posts_path(forum_thread_id: forum_thread.id,
                                           forum_post: attributes_for(
                                             :forum_post, student_id: student.id
                                           ))
      end.to change(ForumPost, :count).by(1)
    end

    it 'redirects to post\'s forum thread' do
      post forum_thread_forum_posts_path(forum_thread_id: forum_thread.id,
                                         forum_post: attributes_for(
                                           :forum_post, student_id: student.id
                                         ))
      expect(response).to redirect_to(forum_thread)
    end
  end

  describe 'PATCH #update' do
    it 'updates the forum post' do
      new_content = 'this is new content for the post'
      patch forum_thread_forum_post_path(forum_thread_id: forum_thread.id, id: forum_post.id,
                                         forum_post: { content: new_content })
      forum_post.reload
      expect(forum_post.content).to eq(new_content)
    end

    it 'renders post\'s forum thread' do
      new_content = 'this is new content for the post'
      patch forum_thread_forum_post_path(forum_thread_id: forum_thread.id, id: forum_post.id,
                                         forum_post: { content: new_content })
      expect(response).to redirect_to(forum_thread)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys forum post' do
      forum_post
      expect do
        delete forum_thread_forum_post_path(id: forum_post.id, forum_thread_id: forum_thread.id)
      end.to change(ForumPost, :count).by(-1)
    end

    it 'renders post\'s forum thread' do
      forum_post
      forum_thread = forum_post.forum_thread
      delete forum_thread_forum_post_path(id: forum_post.id, forum_thread_id: forum_thread.id)
      expect(response).to redirect_to(forum_thread)
    end
  end
end
