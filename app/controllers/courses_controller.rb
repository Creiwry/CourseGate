# frozen_string_literal: true

## CoursesController handles the management of the Courses
#
##
class CoursesController < ApplicationController
  before_action :authenticate_instructor!, except: %i[index show]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @materials = Material.where(course_id: @course.id)

    return unless current_student && current_student.enrollments.exists?(course: @course)

    @enrollment = Enrollment.find_by(student_id: current_student.id, course_id: @course.id)
    @enrollment_id = @enrollment.id
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.instructor_id = current_instructor.id
    if @course.save!
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    course_id = @course.id

    if current_instructor == @course.instructor
      if @course.update(course_params)
        flash[:notice] = 'Course has been updated'
        redirect_to course_path(params[:id])
      else
        flash[:notice] = 'Failed to update Course'
        render :edit
      end
    else
      flash[:notice] = 'You are not authorized to edit this Course'
      redirect_to course_path(course_id)
    end
  end

  def destroy
    course = Course.find(params[:id])
    course_id = course.id

    if current_instructor == course.instructor
      flash[:notice] = if course.destroy
                         'Course has been deleted'
                       else
                         'Failed to delete the course'
                       end
    else
      flash[:notice] = 'You are not authorized to delete this Course'
      redirect_to course_path(course_id)
    end
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end
end
