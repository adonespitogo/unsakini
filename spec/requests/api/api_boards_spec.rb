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
    before(:all) do
      user_has_board_scenario
    end
    it "returns http unauthorized" do
      get api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user's boards" do
      get api_boards_path, headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(parse_json(response.body, '0')).to match_json_schema(:board)
      expect(response.body).to be_json_eql(serialize(@user.user_boards.all))
    end
  end

  describe "POST /api/boards" do

    before(:all) do
      create_board_scenario
    end

    it "returns http unauthorized" do
      post api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "rejects invalid board name" do
      prev_boards_count = @user.boards.count
      preve_user_boards_count = @user.user_boards.count
      post api_boards_path, params: invalid_board_name_param, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(@user.boards.count).to eq(prev_boards_count)
      expect(@user.user_boards.count).to eq(preve_user_boards_count)
    end

    it "rejects invalid encrypted_password" do
      prev_boards_count = @user.boards.count
      preve_user_boards_count = @user.user_boards.count
      post api_boards_path, params: invalid_encrypted_password_param, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(@user.boards.count).to eq(prev_boards_count)
      expect(@user.user_boards.count).to eq(preve_user_boards_count)
    end

    it "creates new board" do
      prev_boards_count = @user.boards.count
      preve_user_boards_count = @user.user_boards.count
      post api_boards_path, params: valid_board_params, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:created)
      expect(parse_json(response.body)).to match_json_schema(:board)
      expect(body_to_json["board"]["name"]).to eq(valid_board_params[:board][:name])
      expect(body_to_json["encrypted_password"]).to eq(valid_board_params[:encrypted_password])
      expect(body_to_json["is_admin"]).to be true
    end
  end

  context "My Boards" do

    before(:all) do
      user_has_board_scenario
      @user_2 = create(:user)
    end

    describe "GET /api/boards/:id" do

      before(:all) do
        user_has_board_scenario
        @user_2 = create :user
      end

      it "returns http unauthorized" do
        get api_board_path(@board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http not_found" do
        get api_board_path({id: 1000000}), headers: auth_headers(@user)
        expect(response).to have_http_status(:not_found)
      end

      it "returns http forbidden" do
        get api_board_path(@board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end

      it "returns board resource" do
        get api_board_path(@board), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:board)
        expect(response.body).to be_json_eql(serialize(@user_board))
      end
    end

    describe "PUT /api/boards/:id" do

      it "returns http unauthorized" do
        put api_board_path(@board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http forbidden" do
        put api_board_path(@board), params: valid_board_params, headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
      end

      it "returns http not_found" do
        put api_board_path({id: 1000000}), params: valid_board_params, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:not_found)
      end

      it "rejects invalide encrypted_password" do
        put api_board_path(@board), params: invalid_encrypted_password_param, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        @board.reload
        @user_board.reload
        expect(@board.name).not_to eq(invalid_encrypted_password_param[:board][:name])
        expect(@user_board.encrypted_password).not_to eq(invalid_encrypted_password_param[:encrypted_password])
      end

      it "rejects invalid board name" do
        put api_board_path(@board), params: invalid_board_name_param, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        @board.reload
        @user_board.reload
        expect(@board.name).not_to eq(invalid_board_name_param[:board][:name])
        expect(@user_board.encrypted_password).not_to eq(invalid_board_name_param[:encrypted_password])
      end

      it "updates the board resource" do
        put api_board_path(@board), params: valid_board_params, headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:board)
        # debugger
        expect(parse_json(response.body)['board']['name']).to eq(valid_board_params[:board][:name])
        @user_board.reload
        expect(response.body).to be_json_eql(serialize(@user_board))
      end
    end

    describe "DELETE /api/boards/:id" do

      it "returns http unauthorized" do
        delete api_board_path(@board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http forbidden if not board owner" do
        delete api_board_path(@board), headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
      end

      it "returns http not_found" do
        delete api_board_path({id: 1000000}), headers: auth_headers(@user), as: :json
        expect(response).to have_http_status(:not_found)
      end

      it "deletes the board resource and its post and comments" do
        expect(Board.find_by_id(@board.id)).not_to be_nil
        expect(UserBoard.where(board_id: @board.id).all).not_to be_empty
        expect(Post.where(board_id: @board.id).all).not_to be_empty
        expect(Comment.where(post_id: @post.id).all).not_to be_empty
        expect{delete api_board_path(@board), headers: auth_headers(@user), as: :json}
        .to change{@user.boards.count}.by(-1)
        expect(response).to have_http_status(:ok)
        expect(Board.find_by_id(@board.id)).to be_nil
        expect(UserBoard.where(board_id: @board.id).all).to be_empty
        expect(Post.where(board_id: @board.id).all).to be_empty
        expect(Comment.where(post_id: @post.id).all).to be_empty
      end
    end
  end

  context "Shared Board" do

  	before(:all) do
  		user_has_shared_board_scenario
  	end

    describe "GET /api/boards/:id" do

      it "returns http unauthorized" do
        get api_board_path(@shared_board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns board resource" do
        get api_board_path(@shared_board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:board)
        expect(response.body).to be_json_eql(serialize(@shared_user_board_2))
      end
    end

    describe "PUT /api/boards/:id" do
      it "updates the board resource" do
        put api_board_path(@shared_board), params: valid_board_params, headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
        @shared_board.reload
        expect(@shared_board.name).not_to eq(valid_board_params[:board][:name])
        expect(@shared_user_board_2.encrypted_password).not_to eq(valid_board_params[:encrypted_password])
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
