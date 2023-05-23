# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.integer :enrollment_id
      t.integer :assignment_id
      t.float :score
      t.text :content

      t.timestamps
    end
    add_index :submissions, :enrollment_id
    add_index :submissions, :assignment_id
  end
end
