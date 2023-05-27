# frozen_string_literal: true

# == Schema Information
#
# Table name: instructors
#
#  id                     :bigint           not null, primary key
#  bio                    :text
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
#  index_instructors_on_email                 (email) UNIQUE
#  index_instructors_on_reset_password_token  (reset_password_token) UNIQUE
#
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
