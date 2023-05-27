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
FactoryBot.define do
  factory :material do
    course
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
