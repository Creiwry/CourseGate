# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_enrollments_on_course_id   (course_id)
#  index_enrollments_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (student_id => students.id)
#
require 'spec_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    
    let(:enrollment) { build(:enrollment) }

    it 'is valid with valid attributes' do
      expect(enrollment).to be_valid
    end

    it 'is not valid without a student_id' do
      enrollment.student_id = nil
      expect(enrollment).not_to be_valid
    end

    it 'is not valid without a course_id' do
      enrollment.course_id = nil
      expect(enrollment).not_to be_valid
    end

    it 'is not valid with a duplicate student and course combination' do
      existing_enrollment = create(:enrollment)
      enrollment.student_id = existing_enrollment.student_id
      enrollment.course_id = existing_enrollment.course_id
      expect(enrollment).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:course) }
  end
end
