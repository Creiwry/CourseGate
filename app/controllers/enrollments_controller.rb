class EnrollmentsController < ApplicationController
  before_action :authenticate_student!

  def index
    user = current_student
    @enrollments = Enrollment.where(student_id: user.id)
  end

  def show
  end

  def new
    @enrollment = Enrollment.new
    @course = Course.find(params[:course_id])
  end

  def create
    @enrollment = Enrollment.new(enrollment_params.merge(student_id: current_student.id))
    if @enrollment.save!
      redirect_to course_path(@enrollment.course)
    else
      render :new
    end
  end

  def destroy
    enrollment = Enrollment.find(params[:id])
    if enrollment.destroy
      flash[:notice] = "Enrollment has been deleted successfully."
    else
      flash[:error] = "Failed to delete the enrollment."
    end
    redirect_to enrollments_path
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:course_id)
  end
end
