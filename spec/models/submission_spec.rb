# frozen_string_literal: true
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
