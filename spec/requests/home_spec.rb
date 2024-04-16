require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "root path" do
    it 'returns a success' do
      get root_path
      expect(response).to be_successful
    end
  end
end
