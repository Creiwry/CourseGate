class EnrollmentsController < ApplicationController
  before_action :authenticate_student!

  def create
    @enrollment = Enrollment.new(enrollment_params.merge(student_id: current_student.id))
    if @enrollment.save!
      flash[:notice] = "Enrollment successful"
      redirect_to course_path(@enrollment.course)
    else
      flash[:error] = "Failed to enroll"
      render :new
    end
  end

  def destroy
    enrollment = Enrollment.find(params[:id])
    course_id = enrollment.course.id
    if enrollment.destroy
      flash[:notice] = "Unenrollment successful"
    else
      flash[:error] = "Failed to unenroll"
    end
    redirect_to course_path(course_id)
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:course_id)
  end
end
