require 'spec_helper'

RSpec.describe MaterialsController, type: :controller do
  let(:material) { create(:material) }
  let(:course) { material.course }
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
      get :show, params: { course_id: course.id, id: material.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {course_id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when instructor who created the course is signed in' do
      it 'creates a new material' do
        expect {
          post :create, params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        }.to change(Material, :count).by(1)
      end

      it 'redirects to created material' do
        post :create, params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        expect(response).to redirect_to(course_material_path(course.id, Material.last.id))
      end
    end

    context 'when instructor who created the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will raise an error' do
        post :create, params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        expect(flash[:error]).to eq('You are not authorized to create this material')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { course_id: course.id, id: material.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when instructor who made the course is signed in' do
      it 'updates the material' do
        new_title = 'New materials title'
        patch :update, params: { course_id: course.id, id: material.id, material: { title: new_title } }
        material.reload
        expect(material.title).to eq(new_title)
      end

      it 'redirects to the material' do
        patch :update, params: { course_id: course.id, id: material.id, material: attributes_for(:material) }
        expect(response).to redirect_to(course_material_path(course.id, material.id))
      end
    end

    context 'when instructor who made the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will fail raise an error' do
        patch :update, params: { course_id: course.id, id: material.id, material: attributes_for(:material) }
        expect(flash[:error]).to eq('You are not authorized to edit this material')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when instructor who created the material is signed in' do
      it 'destroys the material' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        expect {
          delete :destroy, params: { course_id: course.id, id: material.id }
        }.to change(Material, :count).by(-1)
      end

      it 'redirects to the course' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        delete :destroy, params: { course_id: course.id, id: material.id }
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

        delete :destroy, params: { course_id: course.id, id: material.id }
        expect(flash[:error]).to eq('You are not authorized to delete this material')
      end
    end
  end
end
