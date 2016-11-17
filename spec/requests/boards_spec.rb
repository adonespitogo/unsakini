require 'rails_helper'

RSpec.describe "Boards API", type: :request do

  before(:all) do
    @user = create(:user)
    @board = create(:board, name: 'name ni')
    @user_board = create(:user_board, {user_id: @user.id, board_id: @board.id, is_admin: true})
  end

  describe "GET /api/boards" do
    it "returns http unauthorized" do
      get api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns boards" do
      get api_boards_path, params: nil, headers: auth_headers(@user)
      expect(response.body).to look_like_json
      expect(body_as_json).to match(json_str_to_hash(@user.boards.all.to_json))
    end
  end

  describe "POST /api/boards" do
    let(:valid_attributes) {
      {
        name: "sample"
      }
    }
    let(:invalid_attributes) {
      {}
    }

    it "returns http unauthorized" do
      post api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http unprocessable_entity" do
      post api_boards_path, params: invalid_attributes, headers: auth_headers(@user)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http created" do
      post api_boards_path, params: valid_attributes, headers: auth_headers(@user), as: :json
      expect{post api_boards_path, params: valid_attributes, headers: auth_headers(@user), as: :json}
      .to change{@user.boards.count}.by(1)
    end
  end

  describe "POST /api/boards"
end
