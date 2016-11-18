require 'rails_helper'

RSpec.describe "Api::Board::Post::Comments", type: :request do

  before(:each) do
    @user = create(:user)
    @board = create(:board)
    @user_board = create(:user_board, {
      is_admin: true,
      user_id: @user.id,
      board_id: @board.id
    })
    @post = create(:post, {
      user_id: @user.id,
      board_id: @board.id
    })
    @comment = create(:comment, {
      user_id: @user.id,
      post_id: @post.id
    })


    @other_user = create(:user)
    @other_board = create(:board)
    @other_user_board = create(:user_board, {
      is_admin: true,
      user_id: @other_user.id,
      board_id: @other_board.id
    })
    @other_post = create(:post, {
      user_id: @other_user.id,
      board_id: @other_board.id
    })
    @other_comment = create(:comment, {
      user_id: @other_user.id,
      post_id: @other_post.id
    })
  end

  describe "GET /api_board_post_comments" do
    it "returns http unauthorized" do
      get api_board_post_comments_path(@board, @post)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns http unauthorized" do
      get api_board_post_comments_path(@other_board, @post), headers: auth_headers(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns http unauthorized" do
      get api_board_post_comments_path(@other_board, @other_post), headers: auth_headers(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns http unauthorized" do
      get api_board_post_comments_path(@board, @other_post), headers: auth_headers(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns post comments" do
      get api_board_post_comments_path(@board, @post), headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(body_as_hash).to match(model_as_hash(@post.comments))
    end
  end
end
