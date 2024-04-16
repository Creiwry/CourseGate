require 'rails_helper'

RSpec.describe 'Submissions', type: :request do
  let(:submission) { create(:submission) }
  let(:assignment) { submission.assignment }
  let(:enrollment) { submission.enrollment }
  let(:student) { enrollment.student }
  let(:course) { enrollment.course }
  let(:instructor) { course.instructor }

  before do
    sign_in(student)
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get course_assignment_submission_path(
        course_id: course.id,
        assignment_id: assignment.id,
        id: submission.id
      )
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_course_assignment_submission_path(
        course_id: course.id,
        assignment_id: assignment.id
      )
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new submission' do
      expect do
        post course_assignment_submissions_path(
          course_id: course.id,
          assignment_id: assignment.id,
          submission: attributes_for(:submission)
        )
      end.to change(Submission, :count).by(1)
    end

    it 'renders submission' do
      post course_assignment_submissions_path(
        course_id: course.id,
        assignment_id: assignment.id,
        submission: attributes_for(:submission)
      )
      new_submission = Submission.last
      expect(response).to redirect_to(
        course_assignment_submission_path(
          course.id,
          assignment.id,
          new_submission.id
        )
      )
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_course_assignment_submission_path(
        course_id: course.id,
        assignment_id: assignment.id,
        id: submission.id
      )
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the submission' do
      new_content = 'New content for submission. Fun, fun, fun.'

      patch course_assignment_submission_path(
        course_id: course.id,
        assignment_id: assignment.id,
        id: submission.id,
        submission: { content: new_content }
      )

      submission.reload

      expect(submission.content).to eq(new_content)
    end

    it 'redirects to the submission' do
      patch course_assignment_submission_path(
        course_id: course.id,
        assignment_id: assignment.id,
        id: submission.id,
        submission: attributes_for(:submission)
      )

      expect(response).to redirect_to(
        course_assignment_submission_path(
          course.id,
          assignment.id,
          submission.id
        )
      )
    end
  end

  describe 'PATCH #score' do
    context 'when instructor of submission course tries to update score' do
      before do
        sign_out(student)
        sign_in(submission.assignment.course.instructor)
      end

      it 'updates the submission score' do
        new_score = 75
        patch score_course_assignment_submission_path(
          course_id: course.id,
          assignment_id: assignment.id,
          id: submission.id,
          submission: { score: new_score }
        )
        submission.reload
        expect(submission.score).to eq(new_score)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the submission' do
      submission = Submission.new(
        attributes_for(
          :submission,
          enrollment_id: enrollment.id
        )
      )
      submission.save

      expect do
        delete course_assignment_submission_path(
          course_id: course.id,
          assignment_id: assignment.id,
          id: submission.id
        )
      end.to change(Submission, :count).by(-1)
    end

    context 'when student signed in' do
      it 'redirects to assignment' do
        submission = Submission.new(
          attributes_for(
            :submission,
            enrollment_id: enrollment.id
          )
        )
        submission.save

        delete course_assignment_submission_path(
          course_id: course.id,
          assignment_id: assignment.id,
          id: submission.id
        )
        expect(response).to redirect_to(
          course_assignment_path(
            course.id,
            assignment.id
          )
        )
      end
    end

    context 'when assigning instructor is signed in' do
      before do
        sign_out(student)
        sign_in(instructor)
      end

      it 'redirects to submissions' do
        submission = Submission.new(
          attributes_for(
            :submission,
            enrollment_id: enrollment.id
          )
        )
        submission.save

        delete course_assignment_submission_path(
          course_id: course.id,
          assignment_id: assignment.id,
          id: submission.id
        )
        expect(response).to redirect_to(
          course_assignment_submissions_path(
            course.id,
            assignment.id
          )
        )
      end
    end
  end
end
