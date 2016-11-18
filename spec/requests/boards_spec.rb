require 'rails_helper'

RSpec.describe "Boards API", type: :request do

  before(:all) do
    Timecop.freeze
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
      expect(response.body).to look_like_json
      expect(body_as_hash[0]).to equal_model_hash(@user.user_boards.first)
      expect(body_as_hash[0]["board"]).to equal_model_hash(@board)
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
      expect(body_as_hash).to equal_model_hash(@user.user_boards.last)
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
      expect(body_as_hash).to equal_model_hash(@user_board)
    end
  end

  describe "PUT /api/boards/:id" do

    it "returns http unauthorized" do
      put api_board_path(@board)
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http not_found" do
      put api_board_path({id: 1000000}), params: {name: 'board name'}, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:not_found)
    end

    it "returns http unprocessable_entity" do
      put api_board_path(@board), params: {name: ''}, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "updates the board resource" do
      new_board = build(:board)
      put api_board_path(@board), params: new_board, headers: auth_headers(@user), as: :json
      expect(body_as_hash["board"]["name"]).to eq(new_board.name)
      @user.reload
      @user_board.reload
      @board.reload
      expect(body_as_hash).to equal_model_hash(@user_board)
    end
  end

  describe "DELETE /api/boards/:id" do

    it "returns http unauthorized" do
      delete api_board_path(@board)
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http unauthorized if not board owner" do
      not_owner = create(:user)
      delete api_board_path(@board), headers: auth_headers(not_owner), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http not_found" do
      delete api_board_path({id: 1000000}), headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:not_found)
    end

    it "deletes the board resource" do
      expect{delete api_board_path(@board), headers: auth_headers(@user), as: :json}
      .to change{@user.boards.count}.by(-1)
      expect(response).to have_http_status(:ok)
      expect(Board.find_by_id(@board.id)).to be_nil
      expect(UserBoard.where(board_id: @board.id).all).to be_empty
    end
  end
end
