class ForumPostsController < ApplicationController
  before_action :authenticate_student!, except: [:destroy]

  def create
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post = ForumPost.new(
      forum_post_params.merge(
        student_id: current_student.id,
        forum_thread_id: @forum_thread.id
      )
    )
    if @forum_post.save!
      flash[:notice] = 'Post created successfully'
      redirect_to forum_thread_path(@forum_thread)
    else
      flash[:notice] = 'Failed to create post'
      render :new
    end
  end

  def edit
    @forum_post = ForumPost.find(params[:id])
  end

  def update
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post = ForumPost.find(params[:id])

    if @forum_post.update(forum_post_params)
      flash[:notice] = 'Post has been edited'
      redirect_to forum_thread_path(@forum_thread)
    else
      flash[:notice] = 'Failed to edit post'
      render 'partial/new'
    end
  end

  def destroy
    forum_post = ForumPost.find(params[:id])
    forum_thread_id = forum_post.forum_thread_id
    flash[:notice] = if forum_post.destroy
                       'Post has been deleted'
                     else
                       'Failed to delete Post'
                     end
    redirect_to forum_thread_path(forum_thread_id)
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:content, :forum_thread_id)
  end
end
