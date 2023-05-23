# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Instructor, type: :model do
  describe 'validations' do
    let(:instructor) { build(:instructor) }

    it 'is valid with valid attributes' do
      expect(instructor).to be_valid
    end

    it 'is not valid without a name' do
      instructor.name = nil
      expect(instructor).not_to be_valid
    end

    it 'is not valid without an email' do
      instructor.email = nil
      expect(instructor).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      instructor.save!
      duplicate_instructor = build(:instructor, email: instructor.email)
      expect(duplicate_instructor).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:courses) }
  end
end
