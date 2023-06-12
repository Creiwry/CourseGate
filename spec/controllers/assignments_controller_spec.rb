require 'spec_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:assignment) { create(:assignment) }
  let(:course) { assignment.course }
  let(:instructor) { course.instructor }

  before do
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
    context 'when instructor of course is signed in' do
      it 'creates a new assignment' do
        expect {
          post :create, params: { assignment: attributes_for(:assignment) }
        }.to change(Assignment, :count).by(1)
      end
    end

    context 'when instructor of course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        expect {
          post :create, params: { assignment: attributes_for(:assignment) }
        }.to raise_error('You are not authorized to create an assignment for this course')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when instructor of course is signed in' do
      it 'updates the assignment' do
        new_title = 'New Title'
        patch :update, params: { assignment: attributes_for(:assignment, title: new_title) }
        assignment.reload
        expect(assignment.title).to eq(new_title)
      end

      it 'redirects to assignment' do
        patch :update, params: { assignment: attributes_for(:assignment) }
        expect(response).to redirect_to(assignment)
      end
    end

    context 'when instructor of course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        patch :update, params: { assignment: attributes_for(:assignment) }
        expect(response).to raise_error('You are not authorized to update this assignment')
      end

      it 'redirects to assignment' do
        patch :update, params: { assignment: attributes_for(:assignment) }
        expect(response).to redirect_to(assignment)
      end
    end
  end

  describe 'DELETE # destroy' do
    context 'when instructor of assignment is signed in' do
      it 'destroys the assignment' do
        assignment
        expect {
          delete :destroy, params: { id: assignment.id }
        }.to change(Assignment, :count).by(-1)
      end

      it 'redirects to assignments' do
        assignment
        delete :destroy, params: { id: assignment.id }
        expect(response).to redirect_to(assignments_url)
      end
    end

    context 'when instructor of assignment is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        assignment
        delete :destroy, params: { id: assignment.id }
        expect(response).to raise_error('You are not authorized to delete this assignment')
      end

      it 'redirects to assignments' do
        assignment
        delete :destroy, params: { id: assignment.id }
        expect(response).to redirect_to(assignments_url)
      end
    end
  end
end
