class AssignmentsController < ApplicationController
  # def index
  #   @assignments
  # end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    @assignment = Assignment.new
  end

  def create
    course = Course.find(params[:course_id])
    @assignment = Assignment.new(params_for_assignment)
    @assignment.course = course

    unless current_instructor == course.instructor
      flash[:error] = 'You are not authorized to create an assignment for this course'
      redirect_back(fallback_location: root_path)
      return
    end

    if @assignment.save!
      flash[:notice] = 'Assignment created successfully'
      redirect_to course_assignment_path(course.id, @assignment.id)
    else
      flash[:error] = 'Failed to create assignment'
      render :new
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])

    unless current_instructor == course.instructor
      flash[:error] = 'You are not authorized to update this assignment'
      redirect_back(fallback_location: root_path)
      return
    end

    if @assignment.update(params_for_assignment)
      flash[:notice] = 'Assignment updated successfully'
      redirect_to course_assignment_path(course.id, @assignment.id)
    else
      flash[:error] = 'Failed to update assignment'
      render :edit
    end
  end

  def destroy
    course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])

    unless current_instructor == course.instructor
      flash[:error] = 'You are not authorized to delete this assignment'
      redirect_back(fallback_location: root_path)
      return
    end

    if @assignment.destroy
      flash[:notice] = 'Assignment deleted successfully'
      redirect_to course_assignments_path(course.id)
    else
      flash[:error] = 'Failed to delete assignment'
      render :show
    end
  end

  private

  def params_for_assignment
    params.require(:assignment).permit(:course_id, :title, :content, :due_date)
  end
end
