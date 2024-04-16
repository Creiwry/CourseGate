require 'rails_helper'

RSpec.describe "Enrollments", type: :request do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:enrollment) { create(:enrollment) }

  before do
    sign_in(student)
  end

  describe 'POST #create' do
    it 'creates a new enrollment' do
      expect do
        post enrollments_path, params: { enrollment: {course_id: course.id}, student_id: student.id }
      end.to change(Enrollment, :count).by(1)
    end

    it 'redirects to the enrolled course' do
      post enrollments_path, params: { enrollment: { course_id: course.id, student_id: student.id } }
      created_enrollment = Enrollment.last
      expect(response).to redirect_to(created_enrollment.course)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the enrollment' do
      enrollment
      expect do
        delete enrollment_path(enrollment.id)
      end.to change(Enrollment, :count).by(-1)
    end

    it 'redirects to the course' do
      course = enrollment.course
      delete enrollment_path(enrollment.id)
      expect(response).to redirect_to(course)
    end
  end
end
