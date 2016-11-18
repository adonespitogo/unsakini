require 'rails_helper'

# test scope is @user is owner of the board and owner of the post/s
RSpec.describe "Api::Board::Posts", type: :request do

  before(:each) do
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
                                 user_id: @other_user.id,
                                 board_id: @other_board.id
    })
    @other_post = create(:post, {
                           user_id: @other_user.id,
                           board_id: @other_board.id
    })
  end

  let(:valid_attributes) {
    {title: "my title", content: "my conetent"}
  }
  let(:invalid_title_attribute) {
    {title: "", content: "asdfadfa"}
  }
  let(:invalid_content_attribute) {
    {title: "afadsf", content: ""}
  }

  describe "GET /api_board_posts" do
    it "return http unauthorized" do
      get api_board_posts_path(@board)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      get api_board_posts_path(@board)
      expect(response).to have_http_status(:unauthorized), auth_headers(@other_user)
    end
    it "return board posts" do
      get api_board_posts_path(@board), headers: auth_headers(@user)
      expect(body_as_hash).to equal_model_hash(@board.posts.all)
    end
  end

  describe "GET /api_board_post" do
    it "return http unauthorized" do
      get api_board_post_path(@board, @post)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      get api_board_post_path(@board, @post), headers: auth_headers(@other_user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return post" do
      get api_board_post_path(@board, @post), headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(body_as_hash).to equal_model_hash(@post)
    end
  end

  describe "POST /api_board_posts" do

    it "return http unauthorized" do
      post api_board_posts_path(@board), as: :json
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      post api_board_posts_path(@board), headers: auth_headers(@other_user), params: valid_attributes, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unprocessable_entity when invalid title" do
      post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return http unprocessable_entity when invalid content" do
      post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "creates a post belonging to board" do
      board_posts_count = @board.posts.count
      post api_board_posts_path(@board), headers: auth_headers(@user), params: valid_attributes, as: :json
      expect(response).to have_http_status(:created)
      expect(body_as_hash).to equal_model_hash(@board.posts.last)
      expect(@board.posts.count).to eq(board_posts_count+1)
    end
  end

  describe "PUT /api_board_posts" do

    it "return http unauthorized" do
      put api_board_post_path(@board, @post), as: :json
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      put api_board_post_path(@board, @post), headers: auth_headers(@other_user), params: valid_attributes, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unprocessable_entity when invalid title" do
      put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return http unprocessable_entity when invalid content" do
      put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "updates my post belonging to my board" do
      board_posts_count = @board.posts.count
      put api_board_post_path(@board, @post), headers: auth_headers(@user), params: valid_attributes, as: :json
      expect(response).to have_http_status(:ok)
      expect(body_as_hash).to equal_model_hash(@board.posts.last)
      expect(body_as_hash[:title]).to eq(valid_attributes[:title])
      expect(body_as_hash[:content]).to eq(valid_attributes[:content])
    end
  end

  describe "DELETE /api_board_post" do
    it "return http unauthorized" do
      delete api_board_post_path(@board, @post)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return http unauthorized" do
      delete api_board_post_path(@board, @post), headers: auth_headers(@other_user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "return board posts" do
      board_posts_count = @board.posts.count
      delete api_board_post_path(@board, @post), headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(@board.posts.count).to eq(board_posts_count-1)
      expect(Post.find_by_id(@post.id)).to be_nil
    end
  end
end
