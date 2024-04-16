require 'rails_helper'

RSpec.describe "Statics", type: :request do
  describe "GET /about_us" do
    it 'returns a success' do
      get about_us_path
      expect(response).to be_successful
    end
  end

  describe "GET /faq" do
    it 'returns a success' do
      get faq_path
      expect(response).to be_successful
    end
  end
end
