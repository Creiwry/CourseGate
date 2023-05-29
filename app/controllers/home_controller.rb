class HomeController < ApplicationController
  def index
    @courses = Course.all
    @forum_threads = ForumThread.limit(10)
  end
end
