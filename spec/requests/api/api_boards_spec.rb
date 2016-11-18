require 'rails_helper'

RSpec.describe "Api::Boards", type: :request do

  before(:each) do
    Timecop.freeze
    @user = create(:user)
    @user_2 = create(:user)
    @my_board = create(:board, name: 'name ni')
    @my_user_board = create(:user_board, {
                              user_id: @user.id,
                              board_id: @my_board.id,
                              is_admin: true
    })
    @post = create(:post, {
                     user_id: @user.id,
                     board_id: @my_board.id
    })
    @shared_board = create(:board)
    @shared_user_board_1 = create(:user_board, {
                                    user_id: @user.id,
                                    board_id: @shared_board.id,
                                    is_admin: true
    })
    @shared_user_board_2 = create(:user_board, {
                                    user_id: @user_2.id,
                                    board_id: @shared_board.id,
                                    is_admin: false
    })
  end

  let(:valid_attributes) {
    {
      name: "sample"
    }
  }
  let(:invalid_attributes) {
    {name: ""}
  }



  describe "GET /api/boards" do
    it "returns http unauthorized" do
      get api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user's boards" do
      get api_boards_path, params: nil, headers: auth_headers(@user)
      expect(response.body).to look_like_json
      expect(body_as_hash.count).to eq(2)
    end
  end

  describe "POST /api/boards" do

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
      get api_board_path(@my_board)
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http not_found" do
      get api_board_path({id: 1000000}), headers: auth_headers(@user)
      expect(response).to have_http_status(:not_found)
    end

    it "returns http forbidden" do
      get api_board_path(@my_board), headers: auth_headers(@user_2)
      expect(response).to have_http_status(:forbidden)
    end

    it "returns board resource" do
      get api_board_path(@my_board), headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(body_as_hash).to equal_model_hash(@my_user_board)
    end
  end

  describe "My Boards" do

    describe "PUT /api/boards/:id" do

      it "returns http unauthorized" do
        put api_board_path(@my_board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http forbidden" do
        put api_board_path(@my_board), params: {name: 'asdadf'}, headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
      end

      it "returns http not_found" do
        put api_board_path({id: 1000000}), params: {name: 'board name'}, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:not_found)
      end

      it "returns http unprocessable_entity" do
        put api_board_path(@my_board), params: {name: ''}, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "updates the board resource" do
        new_board = build(:board)
        put api_board_path(@my_board), params: new_board, headers: auth_headers(@user), as: :json
        expect(body_as_hash["board"]["name"]).to eq(new_board.name)
        @user.reload
        @my_user_board.reload
        @my_board.reload
        expect(body_as_hash).to equal_model_hash(@my_user_board)
      end
    end

    describe "DELETE /api/boards/:id" do

      it "returns http unauthorized" do
        delete api_board_path(@my_board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http forbidden if not board owner" do
        delete api_board_path(@my_board), headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
      end

      it "returns http not_found" do
        delete api_board_path({id: 1000000}), headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:not_found)
      end

      it "deletes the board resource" do
        expect(Board.find_by_id(@my_board.id)).not_to be_nil
        expect(UserBoard.where(board_id: @my_board.id).all).not_to be_empty
        expect(Post.where(board_id: @my_board.id)).not_to be_empty
        expect(@user.boards.count).to eq 2
        expect{delete api_board_path(@my_board), headers: auth_headers(@user), as: :json}
        .to change{@user.boards.count}.by(-1)
        expect(response).to have_http_status(:ok)
        expect(Board.find_by_id(@my_board.id)).to be_nil
        expect(UserBoard.where(board_id: @my_board.id).all).to be_empty
        expect(Post.where(board_id: @my_board.id)).to be_empty
      end
    end
  end

  describe "Shared Board" do

    describe "GET /api/boards/:id" do

      it "returns http unauthorized" do
        get api_board_path(@shared_board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns board resource" do
        get api_board_path(@shared_board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@shared_user_board_2)
      end
    end

    describe "PUT /api/boards/:id" do
      it "updates the board resource" do
        put api_board_path(@shared_board), params: valid_attributes, headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
        @shared_board.reload
        expect(@shared_board.name).not_to eq(valid_attributes[:name])
      end
    end

    describe "DELETE /api/boards/:id" do

      it "returns http forbidden if not board owner" do
        delete api_board_path(@shared_board), headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
        expect(Board.find(@shared_board.id)).not_to be_nil
      end
    end
  end
end
