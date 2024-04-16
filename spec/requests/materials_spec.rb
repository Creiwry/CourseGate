require 'rails_helper'

RSpec.describe "Materials", type: :request do
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
      get course_material_path(course_id: course.id, id: material.id)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_course_material_path(course_id: course.id)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when instructor who created the course is signed in' do
      it 'creates a new material' do
        expect do
          post course_materials_path(course_id: course.id), params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        end.to change(Material, :count).by(1)
      end

      it 'redirects to created material' do
        post course_materials_path(course_id: course.id), params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        expect(response).to redirect_to(course_material_path(course.id, Material.last.id))
      end
    end

    context 'when instructor who created the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will raise an error' do
        post course_materials_path(course_id: course.id), params: { course_id: course.id, material: attributes_for(:material, course_id: course.id) }
        expect(flash[:error]).to eq('You are not authorized to change this material')
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_course_material_path(course_id: course.id, id: material.id)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when instructor who made the course is signed in' do
      it 'updates the material' do
        new_title = 'New materials title'
        patch course_material_path(course_id: course.id, id: material.id), params: { material: { title: new_title } }
        material.reload
        expect(material.title).to eq(new_title)
      end

      it 'redirects to the material' do
        new_title = 'New materials title'
        patch course_material_path(course_id: course.id, id: material.id), params: { material: { title: new_title } }
        expect(response).to redirect_to(course_material_path(course.id, material.id))
      end
    end

    context 'when instructor who made the course is not signed in' do
      before do
        sign_out(instructor)
      end

      it 'will fail raise an error' do
        new_title = 'New materials title'
        patch course_material_path(course_id: course.id, id: material.id), params: { material: { title: new_title } }
        expect(flash[:error]).to eq('You are not authorized to change this material')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when instructor who created the material is signed in' do
      it 'destroys the material' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        expect do
          delete course_material_path(course_id: course.id, id: material.id)
        end.to change(Material, :count).by(-1)
      end

      it 'redirects to the course' do
        material = Material.new(attributes_for(:material, course_id: course.id))
        material.save

        delete course_material_path(course_id: course.id, id: material.id)
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

        delete course_material_path(course_id: course.id, id: material.id)
        expect(flash[:error]).to eq('You are not authorized to change this material')
      end
    end
  end
end
