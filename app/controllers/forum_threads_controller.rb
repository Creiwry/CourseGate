class ForumThreadsController < ApplicationController
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
    if @forum_thread.save!
      flash[:notice] = 'Forum Thread has been created'
      redirect_to forum_thread_path(@forum_thread.id)
    else
      flash[:notice] = 'Failed to create Forum Thread'
      render :new
    end
  end

  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

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
    else
      flash[:notice] = 'Failed to delete Forum Thread'
    end
    redirect_to forum_threads_path
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :description, :course_id)
  end
end
