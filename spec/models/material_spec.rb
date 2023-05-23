# frozen_string_literal: true

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
