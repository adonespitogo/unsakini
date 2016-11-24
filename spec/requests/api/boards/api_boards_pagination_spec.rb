require 'rails_helper'

RSpec.describe "Api::Boards", type: :request do

  let(:valid_board_params) {
    {
      :board => {:name => "board name"},
      :encrypted_password => Faker::Crypto.md5
    }
  }
  let(:invalid_board_name_param) {
    {
      :board => {:name => nil},
      :encrypted_password => Faker::Crypto.md5
    }
  }
  let(:invalid_encrypted_password_param) {
    {
      :board => {:name => "board name"},
      :encrypted_password => nil
    }
  }

  describe "GET /api/boards" do
    before(:each) do
      user_has_board_scenario
    end
    it "returns http unauthorized" do
      get api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user's boards" do
      get api_boards_path, headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(body_to_json('0')).to match_json_schema(:board)
      expect(response.body).to be_json_eql(serialize(@user.user_boards.all))
    end
  end

end
