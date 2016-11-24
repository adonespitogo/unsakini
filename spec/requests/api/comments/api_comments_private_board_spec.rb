require 'rails_helper'

RSpec.describe "Api::Board::Post::Comments", type: :request do

  before(:all) do
    user_has_shared_board_with_posts_scenario
  end

  let(:valid_attributes) {
    {content: Faker::Hacker.say_something_smart}
  }

  let(:invalid_attributes) {
    {content: nil}
  }

  context "Private board" do

    context "Comments on my post" do

      it "returns http unauthorized" do
        get api_board_post_comments_path(@board, @post)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns http unauthorized" do
        put api_board_post_comment_path(@board, @post, @comment), params: valid_attributes, as: :json
        expect(response).to have_http_status(:unauthorized)
      end


      describe "Get all comments on my post" do
        describe "As a post owner" do
          it "returns all comments" do
            get api_board_post_comments_path(@board, @post), headers: auth_headers(@user)
            expect(response).to have_http_status(:ok)
            expect(body_to_json('0')).to match_json_schema(:comment)
            expect(body_to_json.count).to eq @post.comments.count
          end
        end

        describe "As another user" do
          it "returns http forbidden" do
            get api_board_post_comments_path(@board, @post), headers: auth_headers(@user_2)
            expect(response).to have_http_status(:forbidden)
          end

          it "returns http forbidden" do
            get api_board_post_comments_path(@shared_board, @post), headers: auth_headers(@user_2)
            expect(response).to have_http_status(:forbidden)
          end
        end

      end

      describe "Creating comment to my post" do

        describe "As post owner" do

          it "returns http unauthorized" do
            post api_board_post_comments_path(@board, @post), as: :json, params: valid_attributes
            expect(response).to have_http_status(:unauthorized)
          end

          it "returns http unprocessable_entity" do
            post(
              api_board_post_comments_path(@board, @post),
              headers:  auth_headers(@user),
              params:   invalid_attributes,
              as:       :json
            )
            expect(response).to have_http_status(:unprocessable_entity)
            #todo: assert errors
          end

          it "creates a new comment" do
            comment_count = @post.comments.count
            post(
              api_board_post_comments_path(@board, @post),
              headers:    auth_headers(@user),
              params:     valid_attributes,
              as:         :json
            )
            expect(response).to have_http_status(:ok)
            expect(response.body).to match_json_schema(:comment)
            expect(body_to_json('id')).to eq @post.comments.last.id
            expect(body_to_json('user/id')).to eq @user.id
            expect(Comment.find_by_id(body_to_json('id'))).to eq @post.comments.last
            expect(@post.comments.count).to eq(comment_count+1)
          end
        end

        describe "As another user" do

          it "returns http unauthorized" do
            post api_board_post_comments_path(@board, @post), as: :json, params: valid_attributes
            expect(response).to have_http_status(:unauthorized)
          end

          it "returns http forbidden" do
            post(
              api_board_post_comments_path(@board, @post),
              headers:  auth_headers(@user_2),
              params:   valid_attributes,
              as:       :json
            )
            expect(response).to have_http_status(:forbidden)
          end

        end

      end

      describe "Updating my comment on my post" do

        describe "As comment owner" do

          it "updates my comment if user is me" do
            put(
              api_board_post_comment_path(@board, @post, @comment),
              params:   valid_attributes,
              headers:  auth_headers(@user),
              as:       :json
            )
            expect(response).to have_http_status(:ok)
            expect(response.body).to match_json_schema(:comment)
            expect(body_to_json('content')).to eq @comment.reload.content
            expect(@comment.content).to eq(valid_attributes[:content])
          end
        end

        describe "As another user" do

          it "returns http forbidden if not comment owner" do
            put(
              api_board_post_comment_path(@board, @post, @comment),
              params:   valid_attributes,
              headers:  auth_headers(@user_2),
              as:       :json
            )
            expect(response).to have_http_status(:forbidden)
          end

        end

      end

      describe "Deleting my comment on my post" do

        describe "As comment owner" do

          it "Deletes my comment if user is me" do
            prev_comment_count = @post.comments.count
            delete(
              api_board_post_comment_path(@board, @post, @comment),
              headers:  auth_headers(@user),
            )
            expect(response).to have_http_status(:ok)
            expect(@post.comments.count).to eq(prev_comment_count-1)
            expect(Comment.find_by_id(@comment.id)).to be_nil
          end

        end

        describe "As another user" do

          it "returns http forbidden if not comment owner" do
            prev_comment_count = @post.comments.count
            delete(
              api_board_post_comment_path(@board, @post, @comment),
              headers:  auth_headers(@user_2),
            )
            expect(response).to have_http_status(:forbidden)
            expect(@post.comments.count).to eq(prev_comment_count)
            expect(Comment.find_by_id(@comment.id)).not_to be_nil
          end

          it "Deletes my comment if user is me" do
            prev_comment_count = @post.comments.count
            delete(
              api_board_post_comment_path(@board, @post, @comment),
              headers:  auth_headers(@user),
            )
            expect(response).to have_http_status(:ok)
            expect(@post.comments.count).to eq(prev_comment_count-1)
            expect(Comment.find_by_id(@comment.id)).to be_nil
          end

        end

      end

    end

  end

end
