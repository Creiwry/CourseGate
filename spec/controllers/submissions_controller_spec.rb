require 'spec_helper'

RSpec.describe SubmissionsController, type: :controller do
  let(:submission) { create(:submission) }
  let(:enrollment) { submission.enrollment }
  let(:student) { enrollment.student }
  let(:course) { enrollment.course }
  let(:instructor) { course.instructor }

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
    it 'creates a new submission' do
      expect {
        post :create, params: { submission: attributes_for(:submission) }
      }.to change(Submission, :count).by(1)
    end

    it 'renders submission' do
      post :create, params: { submission: attributes_for(:submission) }
      expect(response).to redirect_to(Submission.last)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the submission' do
      new_title = 'New titile'
      patch :update, params: { id: submission.id, submission: { title: new_title } }
      submission.reload
      expect(submission.title).to eq(new_title)
    end

    it 'redirects to the submission' do
      patch :update, params: { id: submission.id, material: attributes_for(:submission) }
      expect(response).to redirect_to(submission)
    end

    context 'when student tries to update score' do
      it 'raises an error' do
        new_score = 75
        patch :update, params: { id: submission.id, submission: { score: new_score } }
        expect(response).to raise_error('You are not authorized to change submission score')
      end
    end

    context 'when instructor of submission course tries to update score' do
      before do
        sign_out(student)
        sign_in(instructor)
      end

      it 'updates the submission score' do
        new_score = 75
        patch :update, params: { id: submission.id, submission: { score: new_score } }
        submission.reload
        expect(submission.score).to eq(new_score)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the submission' do
      submission = Submission.new(attributes_for(:submission, enrollment_id: enrollment.id))
      submission.save

      expect {
        delete :destroy, params: { id: submission.id }
      }.to change(Submission, :count).by(-1)
    end

    it 'destroys the submission' do
      submission = Submission.new(attributes_for(:submission, enrollment_id: enrollment.id))
      submission.save

      delete :destroy, params: { id: submission.id }
      expect(response).to redirect_to(submissions_url)
    end
  end
end
