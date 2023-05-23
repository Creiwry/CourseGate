# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      student = build(:student)
      expect(student).to be_valid
    end

    it 'is not valid without a name' do
      student = build(:student, name: nil)
      expect(student).to_not be_valid
    end

    it 'is not valid without an email' do
      student = build(:student, email: nil)
      expect(student).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      student = create(:student)
      duplicate_student = build(:student, email: student.email)
      expect(duplicate_student).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:enrollments) }
    it { should have_many(:courses).through(:enrollments) }
  end
end
