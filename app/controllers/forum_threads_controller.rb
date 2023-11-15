# frozen_string_literal: true

## ForumThreadsController handles the management of the Forum Threads
# for courses
##
class ForumThreadsController < ApplicationController
  before_action :authenticate_instructor!, except: %i[index show]
  before_action :check_current_instructor, only: %i[create update destroy]
  before_action :set_forum_thread, except: %i[index new create]

  def index
    @forum_threads = ForumThread.all
  end

  def show
    @forum_posts = @forum_thread.forum_posts
  end

  def new
    @forum_thread = ForumThread.new
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)

    if @forum_thread.save!
      flash[:notice] = 'Forum Thread has been created'
      redirect_to forum_thread_path(@forum_thread.id)
    else
      flash[:notice] = 'Failed to create Forum Thread'
      render :new
    end
  end

  def edit; end

  def update
    @forum_thread = ForumThread.find(params[:id])

    if @forum_thread.update(forum_thread_params)
      flash[:notice] = 'Forum Thread has been updated successfully'
      redirect_to forum_thread_path(@forum_thread.id)
    else
      flash[:notice] = 'Failed to update Forum Thread'
      render :edit
    end
  end

  def destroy
    forum_thread = ForumThread.find(params[:id])

    if forum_thread.destroy
      flash[:notice] = 'Forum Thread has been deleted'
      redirect_to forum_threads_path
    else
      flash[:alert] = 'Failed to delete Forum Thread'
      redirect_to forum_thread_path(forum_thread.id)
    end
  end

  private

  def check_current_instructor
    course = Course.find(params[:forum_thread][:course_id])
    return if current_instructor == course.instructor

    flash[:error] = 'You are not authorized to change this forum thread'
    redirect_back(fallback_location: root_path)
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :description, :course_id)
  end

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:id])
  end
end
