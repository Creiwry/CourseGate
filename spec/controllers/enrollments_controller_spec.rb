
require 'spec_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:enrollment) { create(:enrollment) }

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
      get :show, params: { id: enrollment.id }
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
    it 'creates a new enrollment' do
      expect {
        post :create, params: { enrollment: {course_id: course.id}, student_id: student.id }
      }.to change(Enrollment, :count).by(1)
    end

    it 'redirects to the created course enrolled' do
      post :create, params: { enrollment: { course_id: course.id, student_id: student.id } }
      created_enrollment = Enrollment.last
      expect(response).to redirect_to(created_enrollment.course)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the enrollment' do
      enrollment
      expect {
        delete :destroy, params: { id: enrollment.id }
      }.to change(Enrollment, :count).by(-1)
    end

    it 'redirects to the enrollments list' do
      delete :destroy, params: { id: enrollment.id }
      expect(response).to redirect_to(enrollments_url)
    end
  end
end
