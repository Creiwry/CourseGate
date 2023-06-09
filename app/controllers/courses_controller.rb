class CoursesController < ApplicationController
  before_action :authenticate_instructor!, except: [:index, :show]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
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
    @course = Course.where(id: params[:id])
  end

  def update
    @course = Course.where(id: params[:id])
    if @course.update(course_params)
      flash[:notice] = "Course has been updated"
      redirect_to course_path(params[:id])
    else
      flash[:notice] = "Failed to update Course"
      render :edit
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      flash[:notice] = "Course has been deleted"
    else
      flash[:notice] = "Failed to delete the course"
    end
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end
end
