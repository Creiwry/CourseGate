
require 'spec_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:enrollment) { create(:enrollment) }

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
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new enrollment' do
      expect {
        post :create, params: { enrollment: attributes_for(:enrollment) }
      }.to change(Enrollment, :count).by(1)
    end

    it 'redirects to the created enrollment' do
      post :create, params: { enrollment: attributes_for(:enrollment) }
      expect(response).to redirect_to(Enrollment.last)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: enrollment.id }
      expect(response).to be_successful
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
