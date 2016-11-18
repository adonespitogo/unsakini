require 'rails_helper'

# test scope is @user is owner of the board and owner of the post/s
RSpec.describe "Api::Board::Posts", type: :request do

  before(:each) do
    @user = create :user
    @user_2 = create :user
    @my_board = create :board
    @user_board = create(:user_board, {
                           is_admin: true,
                           user_id: @user.id,
                           board_id: @my_board.id
    })
    @my_post = create(:post, {
                        user_id: @user.id,
                        board_id: @my_board.id
    })
    @shared_board = create :board
    @shared_user_board_1 = create(:user_board, {
                                    is_admin: true,
                                    user_id: @user.id,
                                    board_id: @shared_board.id
    })
    @shared_user_board_2 = create(:user_board, {
                                    is_admin: false,
                                    user_id: @user_2.id,
                                    board_id: @shared_board.id
    })
    @shared_post = create(:post, {
                            user_id: @user.id,
                            board_id: @shared_board.id
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

  describe "Privat Board Posts" do

    describe "Get all posts" do
      it "return http unauthorized" do
        get api_board_posts_path(@my_board)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        get api_board_posts_path(@my_board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return post" do
        get api_board_posts_path(@my_board), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@my_board.posts.all)
      end
    end

    describe "Get single post" do
      it "return http unauthorized" do
        get api_board_post_path(@my_board, @my_post)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        get api_board_post_path(@my_board, @my_post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return post" do
        get api_board_post_path(@my_board, @my_post), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@my_post)
      end
    end

    describe "Create post" do

      it "return http unauthorized" do
        post api_board_posts_path(@my_board), as: :json
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        post api_board_posts_path(@my_board), headers: auth_headers(@user_2), params: valid_attributes, as: :json
        expect(response).to have_http_status(:forbidden)
      end
      it "return http unprocessable_entity when invalid title" do
        post api_board_posts_path(@my_board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "return http unprocessable_entity when invalid content" do
        post api_board_posts_path(@my_board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "successfully creates a post" do
        board_posts_count = @my_board.posts.count
        post api_board_posts_path(@my_board), headers: auth_headers(@user), params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(body_as_hash).to equal_model_hash(@my_board.posts.last)
        expect(@my_board.posts.count).to eq(board_posts_count+1)
      end
    end

    describe "Update my post" do

      it "return http unauthorized" do
        put api_board_post_path(@my_board, @my_post), as: :json
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        put api_board_post_path(@my_board, @my_post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
        expect(response).to have_http_status(:forbidden)
      end
      it "return http forbidden" do
        put api_board_post_path(@shared_board, @my_post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
        expect(response).to have_http_status(:forbidden)
      end
      it "return http unprocessable_entity when invalid title" do
        put api_board_post_path(@my_board, @my_post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "return http unprocessable_entity when invalid content" do
        put api_board_post_path(@my_board, @my_post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "updates my post belonging to my board" do
        put api_board_post_path(@my_board, @my_post), headers: auth_headers(@user), params: valid_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@my_post.reload)
        expect(body_as_hash[:title]).to eq(valid_attributes[:title])
        expect(body_as_hash[:content]).to eq(valid_attributes[:content])
      end
    end

    describe "Delete my post" do
      it "return http unauthorized" do
        delete api_board_post_path(@my_board, @my_post)
        expect(response).to have_http_status(:unauthorized)
      end
      it "return http forbidden" do
        delete api_board_post_path(@my_board, @my_post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return http forbidden" do
        delete api_board_post_path(@shared_board, @my_post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:forbidden)
      end
      it "return board posts" do
        board_posts_count = @my_board.posts.count
        delete api_board_post_path(@my_board, @my_post), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(@my_board.posts.count).to eq(board_posts_count-1)
        expect(Post.find_by_id(@my_post.id)).to be_nil
      end
    end
  end

  describe "Shared Board Posts" do

    describe "Get all posts" do
      it "return http unauthorized" do
        get api_board_posts_path(@shared_board)
        expect(response).to have_http_status(:unauthorized)
      end
      it "returns all posts for first user" do
        get api_board_posts_path(@shared_board), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@shared_board.posts.all)
      end
      it "returns all posts for second user" do
        get api_board_posts_path(@shared_board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@shared_board.posts.all)
      end
    end

    describe "Get single post" do
      it "return http unauthorized" do
        get api_board_post_path(@shared_board, @shared_post)
        expect(response).to have_http_status(:unauthorized)
      end
      it "renders post resource to first user" do
        get api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@shared_post)
      end
      it "renders post resource to 2nd user" do
        get api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:ok)
        expect(body_as_hash).to equal_model_hash(@shared_post)
      end

      describe "Create post" do

        it "return http unauthorized" do
          post api_board_posts_path(@shared_board), as: :json
          expect(response).to have_http_status(:unauthorized)
        end

        describe "Board owner" do
          it "return http unprocessable_entity when invalid title" do
            post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "return http unprocessable_entity when invalid content" do
            post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "successfully creates a post" do
            board_posts_count = @shared_board.posts.count
            post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: valid_attributes, as: :json
            expect(response).to have_http_status(:created)
            expect(body_as_hash).to equal_model_hash(@shared_board.posts.last)
            expect(@shared_board.posts.count).to eq(board_posts_count+1)
          end
        end

        describe "Board shared user" do
          it "return http unprocessable_entity when invalid title" do
            post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: invalid_title_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "return http unprocessable_entity when invalid content" do
            post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: invalid_content_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "successfully creates a post" do
            board_posts_count = @shared_board.posts.count
            post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: valid_attributes, as: :json
            expect(response).to have_http_status(:created)
            expect(body_as_hash).to equal_model_hash(@shared_board.posts.last)
            expect(@shared_board.posts.count).to eq(board_posts_count+1)
          end
        end

      end

      describe "Update my post" do

        # owner of the post in the board should be able to update it
        it "return http unauthorized" do
          put api_board_post_path(@shared_board, @shared_post), as: :json
          expect(response).to have_http_status(:unauthorized)
        end

        describe "Post owner" do
          it "return http unprocessable_entity when invalid title" do
            put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "return http unprocessable_entity when invalid content" do
            put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
          it "updates my post belonging to my board" do
            put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: valid_attributes, as: :json
            expect(response).to have_http_status(:ok)
            expect(body_as_hash).to equal_model_hash(@shared_post.reload)
            expect(body_as_hash[:title]).to eq(valid_attributes[:title])
            expect(body_as_hash[:content]).to eq(valid_attributes[:content])
          end
        end

        # while the shared user should not
        describe "Shared user" do
          it "cannot update the post" do
            put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
            expect(response).to have_http_status(:forbidden)
            @shared_post.reload
            expect(@shared_post.title).to_not eq(valid_attributes[:title])
            expect(@shared_post.content).to_not eq(valid_attributes[:content])
          end
        end
      end
    end

  end
end
