class AddDescriptionToForumThreads < ActiveRecord::Migration[7.0]
  def change
    add_column :forum_threads, :description, :text
  end
end
