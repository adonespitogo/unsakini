require 'rails_helper'

RSpec.describe "Unsakini::Board::Post::Comments", type: :request do

  before(:all) do
    user_has_shared_board_with_posts_scenario
  end

  let(:valid_attributes) {
    {content: Faker::Hacker.say_something_smart}
  }

  let(:invalid_attributes) {
    {content: nil}
  }

  context "Shared Board" do

    context "Comments on My Post" do

      describe "Get all comments on my post" do

        describe "As a post owner" do

          it "returns all comments" do
            get unsakini_board_post_comments_path(@shared_board, @shared_post), headers: auth_headers(@user)
            expect(response).to have_http_status(:ok)
            expect(body_to_json('0')).to match_json_schema(:comment)
            expect(body_to_json.count).to eq @shared_post.comments.count
          end

        end

        describe "As another user" do
          it "returns all comments" do
            get unsakini_board_post_comments_path(@shared_board, @shared_post), headers: auth_headers(@user_2)
            expect(response).to have_http_status(:ok)
            expect(body_to_json('0')).to match_json_schema(:comment)
            expect(body_to_json.count).to eq @shared_post.comments.count
          end
        end

      end

      describe "Creating comment to my post" do

        context "As post owner" do

          it "returns http unprocessable_entity" do
            post(
              unsakini_board_post_comments_path(@shared_board, @shared_post),
              headers:  auth_headers(@user),
              params:   invalid_attributes,
              as:       :json
            )
            expect(response).to have_http_status(:unprocessable_entity)
            #todo: assert errors
          end

          it "creates a new comment" do
            comment_count = @shared_post.comments.count
            post(
              unsakini_board_post_comments_path(@shared_board, @shared_post),
              headers:    auth_headers(@user),
              params:     valid_attributes,
              as:         :json
            )
            expect(response).to have_http_status(:ok)
            expect(response.body).to match_json_schema(:comment)
            expect(body_to_json('content')).to eq valid_attributes[:content]
            expect(body_to_json('user/id')).to eq @user.id
            expect(Unsakini::Comment.find_by_id(body_to_json('id'))).to eq @shared_post.comments.last
            expect(@shared_post.comments.count).to eq(comment_count+1)
          end

        end

        context "As another user" do

          it "returns http unprocessable_entity" do
            post(
              unsakini_board_post_comments_path(@shared_board, @shared_post),
              headers:  auth_headers(@user_2),
              params:   invalid_attributes,
              as:       :json
            )
            expect(response).to have_http_status(:unprocessable_entity)
            # todo: assert errors
          end

          it "creates a new comment" do
            comment_count = @shared_post.comments.count
            post(
              unsakini_board_post_comments_path(@shared_board, @shared_post),
              headers:    auth_headers(@user_2),
              params:     valid_attributes,
              as:         :json
            )
            expect(response).to have_http_status(:ok)
            expect(response.body).to match_json_schema(:comment)
            expect(body_to_json('content')).to eq valid_attributes[:content]
            expect(body_to_json('user/id')).to eq @user_2.id
            expect(Unsakini::Comment.find_by_id(body_to_json('id'))).to eq @shared_post.comments.last
            expect(@shared_post.comments.count).to eq(comment_count+1)
          end

        end

      end

      describe "Updating my comment" do

        context "As comment owner" do
          it "updates my comment if user is me" do
            put(
              unsakini_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
              params:   valid_attributes,
              headers:  auth_headers(@user),
              as:       :json
            )
            expect(response).to have_http_status(:ok)
            expect(body_to_json('content')).to eq(valid_attributes[:content])
            expect(@shared_comment.reload.content).to eq valid_attributes[:content]
          end
        end

        context "As another user" do

          it "returns http forbidden if not comment owner" do
            put(
              unsakini_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
              params:   valid_attributes,
              headers:  auth_headers(@user_2),
              as:       :json
            )
            expect(response).to have_http_status(:forbidden)
          end
        end
      end

      describe "Deleting my comment on my post" do

        context "As comment owner" do

          it "Deletes my comment if user is me" do
            prev_comment_count = @shared_post.comments.count
            delete(
              unsakini_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
              headers:  auth_headers(@user),
            )
            expect(response).to have_http_status(:ok)
            expect(@shared_post.comments.count).to eq(prev_comment_count-1)
            expect(Unsakini::Comment.find_by_id(@shared_comment.id)).to be_nil
          end

        end

        context "As another user" do

          it "returns http forbidden if not comment owner" do
            prev_comment_count = @shared_post.comments.count
            delete(
              unsakini_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
              headers:  auth_headers(@user_2),
            )
            expect(response).to have_http_status(:forbidden)
            expect(@shared_post.comments.count).to eq(prev_comment_count)
            expect(Unsakini::Comment.find_by_id(@shared_comment.id)).not_to be_nil
          end

          it "Deletes my comment if user is me" do
            prev_comment_count = @shared_post.comments.count
            delete(
              unsakini_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
              headers:  auth_headers(@user),
            )
            expect(response).to have_http_status(:ok)
            expect(@shared_post.comments.count).to eq(prev_comment_count-1)
            expect(Unsakini::Comment.find_by_id(@shared_comment.id)).to be_nil
          end

        end

      end

    end

  end

end
