require 'spec_helper'

RSpec.describe MaterialsController, type: :controller do
  let(:material) { create(:material) }
  let(:course) { material.course }
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
    context 'when instructor who created the course is signed in' do
      it 'creates a new material' do
        expect {
          post :create, params: { material: attributes_for(:material, course_id: course.id) }
        }.to change(Material, :count).by(1)
      end

      it 'redirects to created material' do
        post :create, params: { material: attributes_for(:material, course_id: course.id) }
        expect(response).to redirect_to(Material.last)
      end
    end

    context 'when instructor who created the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will raise an error' do
        expect {
          post :create, params: { material: attributes_for(:material, course_id: course.id) }
        }.to raise_error('You are not authorized to create this material')
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
    context 'when instructor who made the course is signed in' do
      it 'updates the material' do
        new_title = 'New materials title'
        patch :update, params: { id: material.id, material: { title: new_title } }
        material.reload
        expect(material.title).to eq(new_title)
      end

      it 'redirects to the material' do
        patch :update, params: { id: material.id, material: attributes_for(:material) }
        expect(response).to redirect_to(material)
      end
    end

    context 'when instructor who made the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will fail raise an error' do
        expect {
          patch :update, params: { id: material.id, material: attributes_for(:material) }
        }.to raise_error('You are not authorized to update this material')
      end
    end
  end

  describe 'delete #destroy' do
    context 'when instructor who created the material is signed in' do
      it 'destroys the material' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        expect {
          delete :destroy, params: { id: material.id }
        }.to change(Material, :count).by(-1)
      end

      it 'redirects to the course' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        delete :destroy, params: { id: material.id }
        expect(response).to redirect_to(course)
      end
    end

    context 'when instructor who created the material is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will fail raise an error' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        expect {
          delete :destroy, params: { id: material.id }
        }.to raise_error('You are not authorized to delete this material')
      end
    end
  end
end
