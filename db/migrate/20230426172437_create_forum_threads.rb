# frozen_string_literal: true

class CreateForumThreads < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_threads do |t|
      t.integer :course_id
      t.string :title

      t.timestamps
    end
    add_index :forum_threads, :course_id
  end
end
