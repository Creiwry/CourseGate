require 'spec_helper'

RSpec.describe ForumPostsController, type: :controller do
  let(:forum_post) { create(:forum_post) }
  let(:forum_thread) { create(:forum_thread) }
  let(:student) { create(:student) }

  before do
    sign_in(student)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new forum post' do
      expect {
        post :create, params: { forum_post: attributes_for(:forum_post, forum_thread_id: forum_thread.id, student_id: student.id) }
      }.to change(ForumPost, :count).by(1)
    end

    it 'renders post\'s forum thread' do
      post :create, params: { forum_post: attributes_for(:forum_post, forum_thread_id: forum_thread.id, student_id: student.id) }
      expect(response).to render(ForumThread.where(id: forum_post.forum_thread_id))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: forum_post.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the forum post' do
      new_content = 'this is new content for the post'
      patch :update, params: { id: forum_post.id, forum_post: { content: new_content } }
      forum_post.reload
      expect(forum_post.content).to eq(new_content)
    end

    it 'renders post\'s forum thread' do
      patch :update, params: { id: forum_post.id, forum_post: attributes_for(:forum_post) }
      expect(response).to render(ForumThread.where(id: forum_post.forum_thread_id))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys forum post' do
      forum_post = ForumPost.new(attributes_for(:forum_post, forum_thread_id: forum_thread.id, student_id: student.id))
      forum_post.save!

      expect {
        delete :destroy, params: { id: forum_post.id }
      }.to change(ForumPost, :count).by(-1)
    end

    it 'renders post\'s forum thread' do
      forum_post = ForumPost.new(attributes_for(:forum_post, forum_thread_id: forum_thread.id, student_id: student.id))
      forum_post.save!
      delete :destroy, params: { id: forum_post.id }
      expect(response).to render(ForumThread.where(id: forum_post.forum_thread_id))
    end
  end
end
