require 'rails_helper'

RSpec.describe "Courses", type: :request do
  let(:course) { create(:course) }
  let(:instructor) { course.instructor }

  before(:each) do
    sign_in(instructor)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: course.id }
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
    it 'creates a new course' do
      expect do
        post :create, params: { course: attributes_for(:course) }
      end.to change(Course, :count).by(1)
    end

    it 'redirects to the created course' do
      post :create, params: { course: attributes_for(:course) }
      expect(response).to redirect_to(Course.last)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the course' do
      new_name = 'New Course Name'
      patch :update, params: { id: course.id, course: { name: new_name } }
      course.reload
      expect(course.name).to eq(new_name)
    end

    it 'redirects to the course' do
      patch :update, params: { id: course.id, course: attributes_for(:course) }
      expect(response).to redirect_to(course)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the course' do
      course
      expect do
        delete :destroy, params: { id: course.id }
      end.to change(Course, :count).by(-1)
    end

    it 'redirects to the courses list' do
      delete :destroy, params: { id: course.id }
      expect(response).to redirect_to(courses_url)
    end
  end
end
