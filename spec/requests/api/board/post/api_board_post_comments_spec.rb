# require 'rails_helper'

# RSpec.describe "Api::Board::Post::Comments", type: :request do

#   before(:all) do
#     Timecop.freeze
#     @user = create(:user)
#   end

#   before(:each) do
#     @user = create(:user)
#     @user_2 = create(:user)

#     @my_board = create(:board)
#     @user_board = create(:user_board, {
#                            is_admin: true,
#                            user_id: @user.id,
#                            board_id: @my_board.id
#     })
#     @my_post = create(:post, {
#                         user_id: @user.id,
#                         board_id: @my_board.id
#     })
#     @my_comment = create(:comment, {
#                            user_id: @user.id,
#                            post_id: @my_post.id
#     })




#     @shared_board = create(:board)
#     @share_user_board_1 = create(:user_board, {
#                                    is_admin: true,
#                                    user_id: @user.id,
#                                    board_id: @shared_board.id
#     })
#     @share_user_board_2 = create(:user_board, {
#                                    is_admin: false,
#                                    user_id: @user_2.id,
#                                    board_id: @shared_board.id
#     })
#     @shared_post = create(:post, {
#                             user_id: @user.id,
#                             board_id: @shared_board.id
#     })
#     @shared_comment = create(:comment, {
#                                user_id: @user.id,
#                                post_id: @shared_post.id
#     })
#   end

#   let(:valid_attributes) {
#     {content: "my comment on this topic"}
#   }

#   let(:invalid_attributes) {
#     {content: ""}
#   }

#   describe "Private board" do

#     describe "Comments on my post" do

#       it "returns http unauthorized" do
#         get api_board_post_comments_path(@my_board, @my_post)
#         expect(response).to have_http_status(:unauthorized)
#       end

#       it "returns http unauthorized" do
#         put api_board_post_comment_path(@my_board, @my_post, @my_comment), params: valid_attributes, as: :json
#         expect(response).to have_http_status(:unauthorized)
#       end


#       describe "Get all comments on my post" do
#         describe "As a post owner" do
#           it "returns all comments" do
#             get api_board_post_comments_path(@my_board, @my_post), headers: auth_headers(@user)
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@my_post.comments))
#           end
#         end

#         describe "As another user" do
#           it "returns http forbidden" do
#             get api_board_post_comments_path(@my_board, @my_post), headers: auth_headers(@user_2)
#             expect(response).to have_http_status(:forbidden)
#           end

#           it "returns http forbidden" do
#             get api_board_post_comments_path(@shared_board, @my_post), headers: auth_headers(@user_2)
#             expect(response).to have_http_status(:forbidden)
#           end
#         end

#       end

#       describe "Creating comment to my post" do

#         describe "As post owner" do
#           it "returns http unauthorized" do
#             post api_board_post_comments_path(@my_board, @my_post), as: :json, params: valid_attributes
#             expect(response).to have_http_status(:unauthorized)
#           end

#           it "returns http unprocessable_entity" do
#             post(
#               api_board_post_comments_path(@my_board, @my_post),
#               headers:  auth_headers(@user),
#               params:   invalid_attributes,
#               as:       :json
#             )
#             expect(response).to have_http_status(:unprocessable_entity)
#           end
#           it "creates a new comment" do
#             comment_count = @my_post.comments.count
#             post(
#               api_board_post_comments_path(@my_board, @my_post),
#               headers:    auth_headers(@user),
#               params:     valid_attributes,
#               as:         :json
#             )
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@my_post.comments.last))
#             expect(@my_post.comments.count).to eq(comment_count+1)
#           end
#         end

#         describe "As another user" do

#           it "returns http unauthorized" do
#             post api_board_post_comments_path(@my_board, @my_post), as: :json, params: valid_attributes
#             expect(response).to have_http_status(:unauthorized)
#           end
#           it "returns http forbidden" do
#             post(
#               api_board_post_comments_path(@my_board, @my_post),
#               headers:  auth_headers(@user_2),
#               params:   valid_attributes,
#               as:       :json
#             )
#             expect(response).to have_http_status(:forbidden)
#           end
#           it "returns http forbidden" do
#             post(
#               api_board_post_comments_path(@my_board, @my_post),
#               headers:  auth_headers(@user_2),
#               params:   valid_attributes,
#               as:       :json
#             )
#             expect(response).to have_http_status(:forbidden)
#           end
#         end

#       end

#       describe "Updating my comment on my post" do
#         describe "As comment owner" do
#           it "updates my comment if user is me" do
#             put(
#               api_board_post_comment_path(@my_board, @my_post, @my_comment),
#               params:   valid_attributes,
#               headers:  auth_headers(@user),
#               as:       :json
#             )
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash[:content]).to eq(valid_attributes[:content])
#           end
#         end

#         describe "As another user" do

#           it "returns http forbidden if not comment owner" do
#             put(
#               api_board_post_comment_path(@my_board, @my_post, @my_comment),
#               params:   valid_attributes,
#               headers:  auth_headers(@user_2),
#               as:       :json
#             )
#             expect(response).to have_http_status(:forbidden)
#           end
#         end
#       end

#       describe "Deleting my comment on my post" do
#         describe "As comment owner" do

#           it "Deletes my comment if user is me" do
#             prev_comment_count = @my_post.comments.count
#             delete(
#               api_board_post_comment_path(@my_board, @my_post, @my_comment),
#               headers:  auth_headers(@user),
#             )
#             expect(response).to have_http_status(:ok)
#             expect(@my_post.comments.count).to eq(prev_comment_count-1)
#             expect(Comment.find_by_id(@my_comment.id)).to be_nil
#           end
#         end
#         describe "As another user" do
#           it "returns http forbidden if not comment owner" do
#             prev_comment_count = @my_post.comments.count
#             delete(
#               api_board_post_comment_path(@my_board, @my_post, @my_comment),
#               headers:  auth_headers(@user_2),
#             )
#             expect(response).to have_http_status(:forbidden)
#             expect(@my_post.comments.count).to eq(prev_comment_count)
#             expect(Comment.find_by_id(@my_comment.id)).not_to be_nil
#           end
#           it "Deletes my comment if user is me" do
#             prev_comment_count = @my_post.comments.count
#             delete(
#               api_board_post_comment_path(@my_board, @my_post, @my_comment),
#               headers:  auth_headers(@user),
#             )
#             expect(response).to have_http_status(:ok)
#             expect(@my_post.comments.count).to eq(prev_comment_count-1)
#             expect(Comment.find_by_id(@my_comment.id)).to be_nil
#           end
#         end
#       end
#     end
#   end

#   describe "Shared board" do
#     describe "Comments on my post" do

#       describe "Get all comments on my post" do

#         describe "As a post owner" do
#           it "returns all comments" do
#             get api_board_post_comments_path(@shared_board, @shared_post), headers: auth_headers(@user)
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@shared_post.comments))
#           end
#         end

#         describe "As another user" do
#           it "returns all comments" do
#             get api_board_post_comments_path(@shared_board, @shared_post), headers: auth_headers(@user_2)
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@shared_post.comments))
#           end
#         end

#       end

#       describe "Creating comment to my post" do

#         describe "As post owner" do
#           it "returns http unprocessable_entity" do
#             post(
#               api_board_post_comments_path(@shared_board, @shared_post),
#               headers:  auth_headers(@user),
#               params:   invalid_attributes,
#               as:       :json
#             )
#             expect(response).to have_http_status(:unprocessable_entity)
#           end
#           it "creates a new comment" do
#             comment_count = @shared_post.comments.count
#             post(
#               api_board_post_comments_path(@shared_board, @shared_post),
#               headers:    auth_headers(@user),
#               params:     valid_attributes,
#               as:         :json
#             )
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@shared_post.comments.last))
#             expect(@shared_post.comments.count).to eq(comment_count+1)
#           end
#         end

#         describe "As another user" do
#           it "returns http unprocessable_entity" do
#             post(
#               api_board_post_comments_path(@shared_board, @shared_post),
#               headers:  auth_headers(@user_2),
#               params:   invalid_attributes,
#               as:       :json
#             )
#             expect(response).to have_http_status(:unprocessable_entity)
#           end
#           it "creates a new comment" do
#             comment_count = @shared_post.comments.count
#             post(
#               api_board_post_comments_path(@shared_board, @shared_post),
#               headers:    auth_headers(@user_2),
#               params:     valid_attributes,
#               as:         :json
#             )
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash).to match(model_as_hash(@shared_post.comments.last))
#             expect(@shared_post.comments.count).to eq(comment_count+1)
#           end
#         end

#       end

#       describe "Updating my comment" do
#         describe "As comment owner" do
#           it "updates my comment if user is me" do
#             put(
#               api_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
#               params:   valid_attributes,
#               headers:  auth_headers(@user),
#               as:       :json
#             )
#             expect(response).to have_http_status(:ok)
#             expect(body_as_hash[:content]).to eq(valid_attributes[:content])
#           end
#         end

#         describe "As another user" do

#           it "returns http forbidden if not comment owner" do
#             put(
#               api_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
#               params:   valid_attributes,
#               headers:  auth_headers(@user_2),
#               as:       :json
#             )
#             expect(response).to have_http_status(:forbidden)
#           end
#         end
#       end

#       describe "Deleting my comment on my post" do
#         describe "As comment owner" do

#           it "Deletes my comment if user is me" do
#             prev_comment_count = @shared_post.comments.count
#             delete(
#               api_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
#               headers:  auth_headers(@user),
#             )
#             expect(response).to have_http_status(:ok)
#             expect(@shared_post.comments.count).to eq(prev_comment_count-1)
#             expect(Comment.find_by_id(@shared_comment.id)).to be_nil
#           end
#         end
#         describe "As another user" do
#           it "returns http forbidden if not comment owner" do
#             prev_comment_count = @shared_post.comments.count
#             delete(
#               api_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
#               headers:  auth_headers(@user_2),
#             )
#             expect(response).to have_http_status(:forbidden)
#             expect(@shared_post.comments.count).to eq(prev_comment_count)
#             expect(Comment.find_by_id(@shared_comment.id)).not_to be_nil
#           end
#           it "Deletes my comment if user is me" do
#             prev_comment_count = @shared_post.comments.count
#             delete(
#               api_board_post_comment_path(@shared_board, @shared_post, @shared_comment),
#               headers:  auth_headers(@user),
#             )
#             expect(response).to have_http_status(:ok)
#             expect(@shared_post.comments.count).to eq(prev_comment_count-1)
#             expect(Comment.find_by_id(@shared_comment.id)).to be_nil
#           end
#         end
#       end
#     end
#   end
# end
