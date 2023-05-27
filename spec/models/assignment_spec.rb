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
require 'spec_helper'

RSpec.describe Assignment, type: :model do
  describe 'validations' do
    it 'is valid with a title, content, course_id, and due_date' do
      assignment = build(:assignment)
      expect(assignment).to be_valid
    end

    it 'is invalid without a title' do
      assignment = build(:assignment, title: nil)
      expect(assignment).to be_invalid
    end

    it 'is invalid without content' do
      assignment = build(:assignment, content: nil)
      expect(assignment).to be_invalid
    end

    it 'is invalid without a course_id' do
      assignment = build(:assignment, course_id: nil)
      expect(assignment).to be_invalid
    end

    it 'is invalid without a due_date' do
      assignment = build(:assignment, due_date: nil)
      expect(assignment).to be_invalid
    end
  end

  describe 'associations' do
    it { should belong_to(:course) }
    it { should have_many(:submissions) }
  end
end
