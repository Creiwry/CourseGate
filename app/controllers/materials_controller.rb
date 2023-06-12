class MaterialsController < ApplicationController
  # def index
  #   course = Course.find(params[:course_id])

  #   unless current_student && current_student.enrollments.includes(course) || current_instructor == course.instructor
  #     flash[:error] = 'You do not have access to these materials'
  #     redirect_back(fallback_location: root_path)
  #     return
  #   end

  #   @materials = Material.where(course_id: course.id)
  # end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
  end

  def create
    course = Course.find(params_for_material[:course_id])

    unless current_instructor == course.instructor
      flash[:error] = 'You are not authorized to create this material'
      redirect_back(fallback_location: root_path)
      return
    end

    @material = Material.new(params_for_material)

    if @material.save!
      flash[:notice] = 'Material created successfully'
      redirect_to course_material_path(course.id, @material.id)
    else
      flash[:error] = 'Failed to create material'
      render :new
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    unless current_instructor == @material.course.instructor
      flash[:error] = 'You are not authorized to edit this material'
      redirect_back(fallback_location: root_path)
      return
    end

    if @material.update(params_for_material)
      flash[:notice] = 'Material updated successfully'
      redirect_to course_material_path(@material.course.id, @material.id)
    else
      flash[:error] = 'Failed to update material'
      render :edit
    end
  end

  def destroy
    @material = Material.find(params[:id])
    course = @material.course

    unless current_instructor == @material.course.instructor
      flash[:error] = 'You are not authorized to delete this material'
      redirect_back(fallback_location: root_path)
      return
    end

    if @material.destroy
      flash[:notice] = 'Material deleted successfully'
      redirect_to course_path(course)
    else
      flash[:error] = 'Failed to delete material'
      render :show
    end
  end

  private

  def params_for_material
    params.require(:material).permit(:course_id, :title, :content)
  end
end
