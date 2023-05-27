# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  description   :text
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instructor_id :bigint           not null
#
# Indexes
#
#  index_courses_on_instructor_id  (instructor_id)
#
# Foreign Keys
#
#  fk_rails_...  (instructor_id => instructors.id)
#
require 'spec_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it 'is valid with a name, description, and instructor' do
      course = build(:course)
      expect(course).to be_valid
    end

    it 'is invalid without a name' do
      course = build(:course, name: nil)
      course.valid?
      expect(course.errors[:name]).to include('can\'t be blank')
    end

    it 'is invalid without an instructor' do
      course = build(:course, instructor: nil)
      course.valid?
      expect(course.errors[:instructor]).to include('must exist')
    end
  end

  describe 'associations' do
    it 'belongs to an instructor' do
      association = described_class.reflect_on_association(:instructor)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many enrollments' do
      association = described_class.reflect_on_association(:enrollments)
      expect(association.macro).to eq :has_many
    end

    it 'has many students through enrollments' do
      course = create(:course)
      student1 = create(:student)
      student2 = create(:student)
      create(:enrollment, course:, student: student1)
      create(:enrollment, course:, student: student2)
      expect(course.students.count).to eq(2)
    end

    it 'has many forum threads' do
      association = described_class.reflect_on_association(:forum_threads)
      expect(association.macro).to eq :has_many
    end

    it 'has many materials' do
      association = described_class.reflect_on_association(:materials)
      expect(association.macro).to eq :has_many
    end

    it 'has many assignments' do
      association = described_class.reflect_on_association(:assignments)
      expect(association.macro).to eq :has_many
    end
  end
end
