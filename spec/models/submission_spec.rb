# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id            :bigint           not null, primary key
#  content       :text
#  score         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignment_id :integer
#  enrollment_id :integer
#
# Indexes
#
#  index_submissions_on_assignment_id  (assignment_id)
#  index_submissions_on_enrollment_id  (enrollment_id)
#
require 'spec_helper'

RSpec.describe Submission, type: :model do
  let(:submission) { build(:submission) }
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(submission).to be_valid
    end

    it 'is not valid without an enrollment' do
      submission.enrollment = nil
      expect(submission).not_to be_valid
    end

    it 'is not valid without an assignment' do
      submission.assignment = nil
      expect(submission).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an enrollment' do
      association = described_class.reflect_on_association(:enrollment)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to an assignment' do
      association = described_class.reflect_on_association(:assignment)
      expect(association.macro).to eq :belongs_to
    end
  end
end
