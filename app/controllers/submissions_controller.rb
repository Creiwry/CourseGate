class SubmissionsController < ApplicationController
  before_action :authenticate_instructor!, only: [:score]

  def index
    enrollment = Enrollment.find_by(course_id: params[:course_id], student_id: current_student.id)
    @submission_of_student = Submission.find_by(enrollment: enrollment.id)
    @submissions = Submission.where(assignment_id: params[:assignment_id])
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @submission = Submission.new
    @assignment = Assignment.find(params[:assignment_id])
  end

  def create
    @submission = Submission.new(params_for_submission)
    enrollment = Enrollment.find_by(
      student_id: current_student.id,
      course_id: params[:course_id]
    )
    @submission.enrollment_id = enrollment.id
    @submission.assignment = Assignment.find(params[:assignment_id])

    if @submission.save!
      flash[:notice] = 'Sucessfully submitted'
      redirect_to course_assignment_submission_path(
        params[:course_id],
        params[:assignment_id],
        @submission.id
      )
    else
      flash[:error] = 'Failed to submit'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def score
    @submission = Submission.find(params[:id])

    unless current_instructor == @submission.assignment.course.instructor
      flash[:error] = 'You are not authorized to change submission score'
      redirect_back(fallback_location: root_path)
      return
    end

    if @submission.update(params_for_scoring)
      flash[:notice] = 'Submission scored successfully'
      redirect_to course_assignment_submission_path(
        params[:course_id],
        params[:assignment_id],
        @submission.id
      )
    else
      flash[:error] = 'Failed to score submission'
      render :edit
    end
  end

  def update
    @submission = Submission.find(params[:id])

    if @submission.update(params_for_submission)
      flash[:notice] = 'Submission updated successfully'
      redirect_to course_assignment_submission_path(
        params[:course_id],
        params[:assignment_id],
        @submission.id
      )
    else
      flash[:error] = 'Failed to update submission'
      render :edit
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    if @submission.destroy
      flash[:notice] = 'Submission deleted successfully'
      if current_instructor
        redirect_to course_assignment_submissions_path(
          params[:course_id],
          params[:assignment_id]
        )
        return
      end

      redirect_to course_assignment_path(
        params[:course_id],
        params[:assignment_id]
      )
    else
      flash[:error] = 'Failed to delete submission'
      render :show
    end
  end

  private

  def params_for_submission
    params.require(:submission).permit(:assignment_id, :content)
  end

  def params_for_scoring
    params.require(:submission).permit(:score)
  end
end
