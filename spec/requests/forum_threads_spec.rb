require 'rails_helper'

RSpec.describe "ForumThreads", type: :request do
  let(:forum_post) { create(:forum_post) }
  let(:forum_thread) { forum_post.forum_thread }
  let(:course) { forum_thread.course }
  let(:instructor) { course.instructor }

  describe 'GET #index' do
    it 'returns a success response' do
      get forum_threads_path
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get forum_thread_path(forum_thread.id)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before do
      sign_in(instructor)
    end

    it 'returns a success response' do
      get new_forum_thread_path
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      sign_in(instructor)
    end

    it 'creates a new forum thread' do
      expect do
        post forum_threads_path, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      end.to change(ForumThread, :count).by(1)
    end

    it 'redirects to the created forum thread' do
      post forum_threads_path, params: { forum_thread: attributes_for(:forum_thread, course_id: course.id) }
      expect(response).to redirect_to(ForumThread.last)
    end
  end

  describe 'GET #edit' do
    before do
      sign_in(instructor)
    end

    it 'returns a success response' do
      get edit_forum_thread_path(forum_thread.id)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    before do
      sign_in(instructor)
    end

    it 'updates the forum thread' do
      new_name = 'New Forum Thread Name'
      patch forum_thread_path(forum_thread.id), params: { id: forum_thread.id, forum_thread: { title: new_name, course_id: forum_thread.course.id } }
      forum_thread.reload
      expect(forum_thread.title).to eq(new_name)
    end

    it 'redirects to the forum thread' do
      patch forum_thread_path(forum_thread.id), params: { id: forum_thread.id, forum_thread: { title: 'newer name', course_id: forum_thread.course.id } }
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
        delete forum_thread_path(forum_thread.id), params: { id: forum_thread.id, forum_thread: { course_id: forum_thread.course.id } }
      end.to change(ForumThread, :count).by(-1)
    end

    it 'redirects to the forum threads list' do
      forum_thread
      delete forum_thread_path(forum_thread.id), params: { id: forum_thread.id, forum_thread: { course_id: forum_thread.course.id } }
      expect(response).to redirect_to(forum_threads_url)
    end
  end

end
