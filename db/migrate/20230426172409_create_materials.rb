# frozen_string_literal: true

class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials do |t|
      t.integer :course_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :materials, :course_id
  end
end
