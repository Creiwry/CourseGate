# frozen_string_literal: true

class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.string :title
      t.text :content
      t.datetime :due_date

      t.timestamps
    end
    add_index :assignments, :course_id
  end
end
