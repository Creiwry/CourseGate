# frozen_string_literal: true

## SubmissionsController handles the management of student
# submissions and instructor scoring in an online learning platform.
##
class SubmissionsController < ApplicationController
  before_action :authenticate_instructor!, only: [:score]
  before_action :check_current_instructor, only: [:score]
  before_action :set_submission, except: %i[new create index]

  def index
    enrollment = Enrollment.find_by(course_id: params[:course_id], student_id: current_student.id)
    @submission_of_student = Submission.find_by(enrollment: enrollment.id)
    @submissions = Submission.where(assignment_id: params[:assignment_id])
  end

  def show; end

  def new
    @submission = Submission.new
    @assignment = Assignment.find(params[:assignment_id])
  end

  def create
    @submission = Submission.new(params_for_submission)
    set_submission_enrollment(@submission)
    @submission.assignment = Assignment.find(params[:assignment_id])

    if @submission.save!
      flash[:notice] = 'Sucessfully submitted'
      redirect_to course_assignment_submission_path(
        *redirect_params,
        @submission.id
      )
    else
      flash[:error] = 'Failed to submit'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit; end

  def score
    content_params = { score: params[:submission][:score] }
    update_submission(
      @submission,
      'Submission scored successfully',
      'Failed to score submission',
      content_params
    )
  end

  def update
    content_params = { content: params[:submission][:content] }
    update_submission(
      @submission,
      'Submission scored successfully',
      'Failed to score submission',
      content_params
    )
  end

  def destroy
    if @submission.destroy
      flash[:notice] = 'Submission deleted successfully'
    else
      flash[:error] = 'Failed to delete submission'
      return render :show
    end

    redirect_path =
      current_instructor ? course_assignment_submissions_path(*redirect_params) : course_assignment_path(*redirect_params)

    redirect_to redirect_path
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_submission_enrollment(submission)
    enrollment = Enrollment.find_by(
      student_id: current_student.id,
      course_id: params[:course_id]
    )
    submission.enrollment_id = enrollment.id
  end

  def params_for_submission
    params.require(:submission).permit(:assignment_id, :content)
  end

  def params_for_scoring
    params.require(:submission).permit(:score)
  end

  def check_current_instructor
    submission = Submission.find(params[:id])
    return if current_instructor == submission.assignment.course.instructor

    flash[:error] = 'You are not authorized to change submission score'
    redirect_back(fallback_location: root_path)
  end

  def redirect_params
    [params[:course_id], params[:assignment_id]]
  end

  def update_submission(submission, success_message, fail_message, params)
    if submission.update(params)
      flash[:notice] = success_message
      redirect_to course_assignment_submission_path(*redirect_params, submission.id)
    else
      flash[:error] = fail_message
      render :edit
    end
  end
end
