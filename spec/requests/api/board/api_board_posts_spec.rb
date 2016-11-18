require 'rails_helper'

RSpec.describe "Api::Board::Posts", type: :request do

  before(:all) do
    @user = create :user
    @board = create :board
    @user_board = create(:user_board, {
      is_admin: true,
      user_id: @user.id,
      board_id: @board.id
    })
    @post = create(:post, {
      user_id: @user.id,
      board_id: @board.id
    })
    @other_user = create :user
    @other_board = create :board
    @other_user_board = create(:user_board, {
      is_admin: true,
      user_id: @user.id,
      board_id: @board.id
    })
    @other_post = create(:post, {
      user_id: @user.id,
      board_id: @board.id
    })
  end

  describe "GET /api_board_posts" do
    it "return http unauthorized" do
      get api_board_posts_path(@board)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      get api_board_posts_path(@other_board), headers: auth_headers(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return board posts" do
      get api_board_posts_path(@board), headers: auth_headers(@user)
      expect(body_as_hash).to equal_model_hash(@board.posts.all)
    end
  end
end
