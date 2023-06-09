require 'spec_helper'

RSpec.describe ForumThreadsController, type: :controller do
  let(:forum_thread) { create(:forum_thread) }
  let(:forum_post) { create(:forum_post) }
  let(:course) { create(:course) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: forum_thread.id }
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
    it 'creates a new forum thread' do
      expect {
        post :create, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      }.to change(ForumThread, :count).by(1)
    end

    it 'redirects to the created forum thread' do
      post :create, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      expect(response).to redirect_to(ForumThread.last)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: forum_thread.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the forum thread' do
      new_name = "New Forum Thread Name"
      patch :update, params: { id: forum_thread.id, forum_thread: { title: new_name } }
      forum_thread.reload
      expect(forum_thread.title).to eq(new_name)
    end

    it 'redirects to the forum_thread' do
      patch :update, params: { id: forum_thread.id, forum_thread: attributes_for(:forum_thread) }
      expect(response).to redirect_to(forum_thread)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the forum thread' do
      forum_thread = ForumThread.new(attributes_for(:forum_thread, course_id: course.id))
      forum_thread.save

      expect {
        delete :destroy, params: { id: forum_thread.id }
      }.to change(ForumThread, :count).by(-1)
    end

    it 'redirects to the forum threads list' do
      delete :destroy, params: { id: forum_thread.id }
      expect(response).to redirect_to(forum_threads_url)
    end
  end
end
