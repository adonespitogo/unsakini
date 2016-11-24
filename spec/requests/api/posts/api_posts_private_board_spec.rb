require 'rails_helper'

# test scope is @user is owner of the board and owner of the post/s
RSpec.describe "Api::Board::Posts", type: :request do

  before(:each) do
    user_has_shared_board_scenario
  end

  let(:valid_attributes) {
    {title: Faker::Name.title, content: Faker::Hacker.say_something_smart}
  }
  let(:invalid_title_attribute) {
    {title: "", content: Faker::Hacker.say_something_smart}
  }
  let(:invalid_content_attribute) {
    {title: Faker::Name.title, content: ""}
  }

  context "Privat Board Posts" do

    describe "Get All Posts" do

      it "return http unauthorized" do
        get api_board_posts_path(@board)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        get api_board_posts_path(@board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return post" do
        get api_board_posts_path(@board), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(body_to_json('0')).to match_json_schema(:post)
        expect(response.body).to be_json_eql(serialize(@board.posts.all))
      end
    end

    describe "Get Single Post" do
      it "return http unauthorized" do
        get api_board_post_path(@board, @post)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        get api_board_post_path(@board, @post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return post" do
        get api_board_post_path(@board, @post), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:post)
        expect(response.body).to be_json_eql(serialize(@post))
      end
    end

    describe "Create Post" do
      it "return http unauthorized" do
        post api_board_posts_path(@board), as: :json
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden when not owner" do
        post api_board_posts_path(@board), headers: auth_headers(@user_2), params: valid_attributes, as: :json
        expect(response).to have_http_status(:forbidden)
      end
      it "return http unprocessable_entity when invalid title" do
        post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        # todo: assert errors
      end
      it "return http unprocessable_entity when invalid content" do
        post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        # todo: assert errors
      end
      it "successfully creates a post" do
        board_posts_count = @board.posts.count
        post api_board_posts_path(@board), headers: auth_headers(@user), params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema(:post)
        expect(response.body).to be_json_eql(serialize(@board.posts.last))
        expect(@board.posts.count).to eq(board_posts_count+1)
      end
    end

    describe "Update Post" do

      it "return http unauthorized" do
        put api_board_post_path(@board, @post), as: :json
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden when not owner" do
        put api_board_post_path(@board, @post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
        expect(response).to have_http_status(:forbidden)
      end
      it "return http unprocessable_entity when invalid title" do
        put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        # todo: assert errors
      end
      it "return http unprocessable_entity when invalid content" do
        put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        # todo: assert errors
      end
      it "updates my post belonging to my board" do
        put api_board_post_path(@board, @post), headers: auth_headers(@user), params: valid_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:post)
        expect(body_to_json('title')).to eq(valid_attributes[:title])
        expect(body_to_json('content')).to eq(valid_attributes[:content])
      end
    end

    describe "Delete Post" do
      it "return http unauthorized" do
        delete api_board_post_path(@board, @post)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden if not owner" do
        delete api_board_post_path(@board, @post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "removes my post" do
        post_id = @post.id
        board_posts_count = @board.posts.count
        delete api_board_post_path(@board, @post), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(@board.posts.count).to eq(board_posts_count-1)
        expect(Post.find_by_id(post_id)).to be_nil
        expect(Comment.where(post_id: post_id)).to be_empty
      end
    end
  end

end
