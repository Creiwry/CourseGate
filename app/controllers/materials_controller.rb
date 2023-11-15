# frozen_string_literal: true

## MaterialsController handles the management of the study materials
# for courses
##
class MaterialsController < ApplicationController
  before_action :set_material, except: %i[new create]
  before_action :check_current_instructor, only: %i[update destroy create]

  def show; end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(params_for_material)

    if @material.save!
      flash[:notice] = 'Material created successfully'
      redirect_to course_material_path(@material.course.id, @material.id)
    else
      flash[:error] = 'Failed to create material'
      render :new
    end
  end

  def edit; end

  def update
    if @material.update(params_for_material)
      flash[:notice] = 'Material updated successfully'
      redirect_to course_material_path(@material.course.id, @material.id)
    else
      flash[:error] = 'Failed to update material'
      render :edit
    end
  end

  def destroy
    course = @material.course

    if @material.destroy
      flash[:notice] = 'Material deleted successfully'
      redirect_to course_path(course)
    else
      flash[:error] = 'Failed to delete material'
      render :show
    end
  end

  private

  def set_material
    @material = Material.find(params[:id])
  end

  def params_for_material
    params.require(:material).permit(:course_id, :title, :content)
  end

  def check_current_instructor
    course = Course.find(params[:course_id])
    return if current_instructor == course.instructor

    flash[:error] = 'You are not authorized to change this material'
    redirect_back(fallback_location: root_path)
  end
end
