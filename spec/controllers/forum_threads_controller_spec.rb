require 'spec_helper'

RSpec.describe ForumThreadsController, type: :controller do
  let(:forum_post) { create(:forum_post) }
  let(:forum_thread) { forum_post.forum_thread }
  let(:course) { forum_thread.course }
  let(:instructor) { course.instructor }

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
    before do
      sign_in(instructor)
    end
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      sign_in(instructor)
    end
    it 'creates a new forum thread' do
      expect do
        post :create, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      end.to change(ForumThread, :count).by(1)
    end

    it 'redirects to the created forum thread' do
      post :create, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      expect(response).to redirect_to(ForumThread.last)
    end
  end

  describe 'GET #edit' do
    before do
      sign_in(instructor)
    end
    it 'returns a success response' do
      get :edit, params: { id: forum_thread.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    before do
      sign_in(instructor)
    end
    it 'updates the forum thread' do
      new_name = 'New Forum Thread Name'
      patch :update, params: { id: forum_thread.id, forum_thread: { title: new_name, course_id: forum_thread.course.id } }
      forum_thread.reload
      expect(forum_thread.title).to eq(new_name)
    end

    it 'redirects to the forum thread' do
      patch :update, params: { id: forum_thread.id, forum_thread: { title: 'newer name', course_id: forum_thread.course.id } }
      expect(response).to redirect_to(forum_thread)
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in(instructor)
    end
    it 'destroys the forum thread' do
      forum_thread

      expect do
        delete :destroy, params: { id: forum_thread.id, forum_thread: { course_id: forum_thread.course.id } }
      end.to change(ForumThread, :count).by(-1)
    end

    it 'redirects to the forum threads list' do
      forum_thread
      delete :destroy, params: { id: forum_thread.id, forum_thread: { course_id: forum_thread.course.id } }
      expect(response).to redirect_to(forum_threads_url)
    end
  end
end
