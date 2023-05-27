# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id         :bigint           not null, primary key
#  content    :text
#  due_date   :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#
# Indexes
#
#  index_assignments_on_course_id  (course_id)
#
FactoryBot.define do
  factory :assignment do
    course { create(:course) }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    due_date { Faker::Time.forward(days: 7) }
  end
end
