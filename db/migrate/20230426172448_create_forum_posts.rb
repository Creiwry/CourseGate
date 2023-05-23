# frozen_string_literal: true

class CreateForumPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_posts do |t|
      t.integer :forum_thread_id
      t.integer :student_id
      t.text :content

      t.timestamps
    end
    add_index :forum_posts, :forum_thread_id
    add_index :forum_posts, :student_id
  end
end
