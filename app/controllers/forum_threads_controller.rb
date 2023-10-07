class ForumThreadsController < ApplicationController
  before_action :authenticate_instructor!, except: %i[index show]

  def index
    @forum_threads = ForumThread.all
  end

  def show
    @forum_thread = ForumThread.find(params[:id])
    @forum_posts = @forum_thread.forum_posts
  end

  def new
    @forum_thread = ForumThread.new
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    instructor = @forum_thread.course.instructor
    course_id = @forum_thread.course.id

    if current_instructor == instructor
      if @forum_thread.save!
        flash[:notice] = 'Forum Thread has been created'
        redirect_to forum_thread_path(@forum_thread.id)
      else
        flash[:notice] = 'Failed to create Forum Thread'
        render :new
      end
    else
      flash[:notice] = 'You are not authorized to create this Forum Thread'
      redirect_to course_path(course_id)
    end
  end

  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

  def update
    @forum_thread = ForumThread.find(params[:id])
    course_id = @forum_thread.course.id

    instructor = @forum_thread.course.instructor
    if current_instructor == instructor
      if @forum_thread.update(forum_thread_params)
        flash[:notice] = 'Forum Thread has been updated successfully'
        redirect_to forum_thread_path(@forum_thread.id)
      else
        flash[:notice] = 'Failed to update Forum Thread'
        render :edit
      end
    else
      flash[:notice] = 'You are not authorized to edit this Forum Thread'
      redirect_to course_path(course_id)
    end
  end

  def destroy
    forum_thread = ForumThread.find(params[:id])
    instructor = forum_thread.course.instructor
    course_id = forum_thread.course.id

    if current_instructor == instructor
      if forum_thread.destroy
        flash[:notice] = 'Forum Thread has been deleted'
      else
        flash[:alert] = 'Failed to delete Forum Thread'
        redirect_to forum_thread_path(forum_thread.id)
        return
      end
      redirect_to forum_threads_path
    else
      flash[:alert] = 'You are not authorized to delete this Forum Thread'
      redirect_to forum_thread_path(forum_thread.id)
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :description, :course_id)
  end
end
