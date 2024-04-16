require 'spec_helper'

RSpec.describe 'Assignments', type: :request do
  let(:assignment) { create(:assignment) }
  let(:student) { create(:student) }
  let(:course) { assignment.course }
  let(:instructor) { course.instructor }
  let(:instructor_not_of_course) { create(:instructor) }

  describe 'GET #index' do
    context 'when no one is signed in' do
      it "redirects to sign in page" do
        get course_assignments_path(course_id: course.id)
        expect(response).to redirect_to(new_instructor_session_path)
      end

      it 'asks user to sign in' do
        get course_assignments_path(course_id: course.id)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context 'when student is signed in' do
      before do
        sign_in(student)
      end

      it 'redirects to sign in page' do
        get course_assignments_path(course_id: course.id)
        expect(response).to redirect_to(new_instructor_session_path)
      end

      it 'asks user to sign in' do
        get course_assignments_path(course_id: course.id)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context 'when the correct instructor is signed in' do
      before do
        sign_in(instructor)
      end

      it 'returns a success response' do
        get course_assignments_path(course_id: course.id)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get course_assignment_path(course_id: course.id, id: assignment.id)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    context 'when no one is signed in' do
      it "redirects to sign in page" do
        get new_course_assignment_path(course_id: course.id)
        expect(response).to redirect_to(new_instructor_session_path)
      end

      it 'asks user to sign in' do
        get new_course_assignments_path(course_id: course.id)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context 'when student is signed in' do
      before do
        sign_in(student)
      end

      it 'redirects to sign in page' do
        get new_course_assignment_path(course_id: course.id)
        expect(response).to redirect_to(new_instructor_session_path)
      end

      it 'asks user to sign in' do
        get new_course_assignment_path(course_id: course.id)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    context 'when the correct instructor is signed in' do
      before do
        sign_in(instructor)
      end

      it 'returns a success response' do
        get new_course_assignment_path(course_id: course.id)
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'when instructor of course is signed in' do
      before do
        sign_in(instructor)
      end
      it 'creates a new assignment' do
        expect do
          post course_assignments_path(course_id: course.id, assignment: attributes_for(:assignment))
        end.to change(Assignment, :count).by(1)
      end

      it 'redirects to assignment' do
        post course_assignments_path(course_id: course.id, assignment: attributes_for(:assignment))
        new_assignment = Assignment.last
        expect(response).to redirect_to(course_assignment_path(course.id, new_assignment.id))
      end
    end

    context 'when instructor of course is not signed in' do
      before(:each) do
        sign_out(instructor)
        sign_in(instructor_not_of_course)
      end

      it 'does not create course' do
        expect do
          post course_assignments_path(course_id: course.id, assignment: attributes_for(:assignment))
        end.to_not(change(Assignment, :count))
      end

      it 'raises an error' do
        post course_assignments_path(course_id: course.id, assignment: attributes_for(:assignment))
        expect(flash[:error]).to eq('You are not authorized to change this assignment')
      end
    end
  end

  describe 'GET #edit' do
    before do
      sign_in(instructor)
    end
    it 'returns a success response' do
      get edit_course_assignment_path(course_id: course.id, id: assignment.id)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when instructor of course is signed in' do
      before do
        sign_in(instructor)
      end
      it 'updates the assignment' do
        new_title = 'New Title'
        patch course_assignment_path(course_id: course.id, id: assignment.id,
                                     assignment: attributes_for(:assignment, title: new_title))
        assignment.reload
        expect(assignment.title).to eq(new_title)
      end

      it 'redirects to assignment' do
        patch course_assignment_path(course_id: course.id, id: assignment.id,
                                     assignment: attributes_for(:assignment, title: 'yello'))
        expect(response).to redirect_to(course_assignment_path(course.id, assignment.id))
      end
    end

    context 'when instructor of course is not signed in' do
      before do
        sign_out(instructor)
        sign_in(instructor_not_of_course)
      end

      it 'raises an error' do
        patch course_assignment_path(course_id: course.id, id: assignment.id,
                                     assignment: attributes_for(:assignment, title: 'yello'))
        expect(flash[:error]).to eq('You are not authorized to change this assignment')
      end
    end
  end

  describe 'DELETE # destroy' do
    context 'when instructor of assignment is signed in' do
      before do
        sign_in(instructor)
      end
      it 'destroys the assignment' do
        assignment
        expect do
          delete course_assignment_path(course_id: course.id, id: assignment.id)
        end.to change(Assignment, :count).by(-1)
      end

      it 'redirects to assignments' do
        assignment
        delete course_assignment_path(course_id: course.id, id: assignment.id)
        expect(response).to redirect_to(course_assignments_path(course.id))
      end
    end

    context 'when instructor of assignment is not signed in' do
      before do
        sign_out(instructor)
        sign_in(instructor_not_of_course)
      end

      it 'raises an error' do
        assignment
        delete course_assignment_path(course_id: course.id, id: assignment.id)
        expect(flash[:error]).to eq('You are not authorized to change this assignment')
      end
    end
  end
end
