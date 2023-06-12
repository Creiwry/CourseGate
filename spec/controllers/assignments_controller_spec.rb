require 'spec_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:assignment) { create(:assignment) }
  let(:course) { assignment.course }
  let(:instructor) { course.instructor }

  before do
    sign_in(instructor)
  end

  # describe 'GET #index' do
  #   it 'returns a success response' do
  #     get :index, params: { course_id: course.id }
  #     expect(response).to be_successful
  #   end
  # end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { course_id: course.id, id: assignment.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { course_id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when instructor of course is signed in' do
      it 'creates a new assignment' do
        expect {
          post :create, params: { course_id: course.id, assignment: attributes_for(:assignment) }
        }.to change(Assignment, :count).by(1)
      end
    end

    context 'when instructor of course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        post :create, params: { course_id: course.id, assignment: attributes_for(:assignment) }
        expect(flash[:error]).to eq('You are not authorized to create an assignment for this course')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { course_id: course.id, id: assignment.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when instructor of course is signed in' do
      it 'updates the assignment' do
        new_title = 'New Title'
        patch :update, params: { course_id: course.id, id: assignment.id, assignment: attributes_for(:assignment, title: new_title) }
        assignment.reload
        expect(assignment.title).to eq(new_title)
      end

      it 'redirects to assignment' do
        patch :update, params: { course_id: course.id, id: assignment.id, assignment: attributes_for(:assignment) }
        expect(response).to redirect_to(course_assignment_path(course.id, assignment.id))
      end
    end

    context 'when instructor of course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        patch :update, params: { course_id: course.id, id: assignment.id, assignment: attributes_for(:assignment) }
        expect(flash[:error]).to eq('You are not authorized to update this assignment')
      end
    end
  end

  describe 'DELETE # destroy' do
    context 'when instructor of assignment is signed in' do
      it 'destroys the assignment' do
        assignment
        expect {
          delete :destroy, params: { course_id: course.id, id: assignment.id }
        }.to change(Assignment, :count).by(-1)
      end

      it 'redirects to assignments' do
        assignment
        delete :destroy, params: { course_id: course.id, id: assignment.id }
        expect(response).to redirect_to(course_assignments_path(course.id))
      end
    end

    context 'when instructor of assignment is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'raises an error' do
        assignment
        delete :destroy, params: { course_id: course.id, id: assignment.id }
        expect(flash[:error]).to eq('You are not authorized to delete this assignment')
      end
    end
  end
end
