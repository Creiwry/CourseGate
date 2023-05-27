# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_students_on_email                 (email) UNIQUE
#  index_students_on_reset_password_token  (reset_password_token) UNIQUE
#
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
