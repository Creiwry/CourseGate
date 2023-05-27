# frozen_string_literal: true

# == Schema Information
#
# Table name: materials
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#
# Indexes
#
#  index_materials_on_course_id  (course_id)
#
require 'spec_helper'

RSpec.describe Material, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      material = build(:material)
      expect(material).to be_valid
    end

    it 'is not valid without a title' do
      material = build(:material, title: nil)
      expect(material).to_not be_valid
    end

    it 'is not valid without a body' do
      material = build(:material, content: nil)
      expect(material).to_not be_valid
    end
  end
end
