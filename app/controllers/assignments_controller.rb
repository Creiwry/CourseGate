# frozen_string_literal: true

## AssignmentsController handles the management of the Assignments
# for courses
##
class AssignmentsController < ApplicationController
  before_action :authenticate_instructor!, except: [:show]
  before_action :check_current_instructor, only: %i[create update destroy]
  before_action :set_assignment, except: %i[index new create]

  def index
    @assignments = Assignment.where(course_id: params[:course_id])
  end

  def show
    return unless current_student

    enrollment = Enrollment.find_by(course_id: params[:course_id], student_id: current_student.id)
    return unless enrollment.submissions.exists?(assignment_id: @assignment.id)

    @submission_id = Submission.find_by(enrollment_id: enrollment.id, assignment_id: @assignment.id)
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(params_for_assignment)
    @assignment.course = Course.find(params[:course_id])

    if @assignment.save!
      flash[:notice] = 'Assignment created successfully'
      redirect_to course_assignment_path(@assignment.course.id, @assignment.id)
    else
      flash[:error] = 'Failed to create assignment'
      render :new
    end
  end

  def edit; end

  def update
    course = Course.find(params[:course_id])

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

    if @assignment.destroy
      flash[:notice] = 'Assignment deleted successfully'
      redirect_to course_assignments_path(course.id)
    else
      flash[:error] = 'Failed to delete assignment'
      render :show
    end
  end

  private

  def check_current_instructor
    course = Course.find(params[:course_id])
    return if current_instructor == course.instructor

    flash[:error] = 'You are not authorized to change this assignment'
    redirect_back(fallback_location: root_path)
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def params_for_assignment
    params.require(:assignment).permit(:course_id, :title, :content, :due_date)
  end
end
