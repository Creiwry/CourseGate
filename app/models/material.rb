# frozen_string_literal: true

# == Schema Information
#
# Table name: materials
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#
# Indexes
#
#  index_materials_on_course_id  (course_id)
#
class Material < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true
end
