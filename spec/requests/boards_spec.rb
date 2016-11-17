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
    it "returns current user's boards" do
      get api_boards_path, params: nil, headers: auth_headers(@user)
      # debugger
      expect(response.body).to look_like_json
      serializer = UserBoardSerializer.new(@user.user_boards.first)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      expect(body_as_json[0]).to match(json_str_to_hash(serialization.to_json))
      expect(body_as_json[0]["board"]).not_to be_empty
    end
  end

  describe "POST /api/boards" do
    let(:valid_attributes) {
      {
        name: "sample"
      }
    }
    let(:invalid_attributes) {
      {name: ""}
    }

    it "returns http unauthorized" do
      post api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http unprocessable_entity" do
      post api_boards_path, params: invalid_attributes, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http created" do
      expect{post api_boards_path, params: valid_attributes, headers: auth_headers(@user), as: :json}
      .to change{@user.boards.count}.by(1)
      @user.reload
      expect(response).to have_http_status(:created)
      serializer = UserBoardSerializer.new(@user.user_boards.last)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      expect(body_as_json).to match(json_str_to_hash(serialization.to_json))
    end
  end

  describe "GET /api/boards/:id" do

    it "returns http unauthorized" do
      get api_board_path(@board)
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http not_found" do
      get api_board_path({id: 1000000}), params: nil, headers: auth_headers(@user)
      expect(response).to have_http_status(:not_found)
    end

    it "returns board resource" do
      get api_board_path(@board), params: nil, headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      serializer = UserBoardSerializer.new(@user_board)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      expect(body_as_json).to match(json_str_to_hash(serialization.to_json))
    end

  end
end
