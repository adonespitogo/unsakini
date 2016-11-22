# require 'rails_helper'

# # test scope is @user is owner of the board and owner of the post/s
# RSpec.describe "Api::Board::Posts", type: :request do

#   before(:all) do
#     Timecop.freeze
#     user_has_shared_board_scenario
#   end

#   let(:valid_attributes) {
#     {title: Faker::Name.title, content: Faker::Hacker.say_something_smart}
#   }
#   let(:invalid_title_attribute) {
#     {title: "", content: Faker::Hacker.say_something_smart}
#   }
#   let(:invalid_content_attribute) {
#     {title: Faker::Name.title, content: ""}
#   }

#   context "Privat Board Posts" do

#     describe "Get All Posts" do

#       it "return http unauthorized" do
#         get api_board_posts_path(@board)
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "return http forbidden" do
#         get api_board_posts_path(@board), headers: auth_headers(@user_2)
#         expect(response).to have_http_status(:forbidden)
#       end
#       it "return post" do
#         get api_board_posts_path(@board), headers: auth_headers(@user)
#         expect(response).to have_http_status(:ok)
#         expect(body_to_json('0')).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@board.posts.all))
#       end
#     end

#     describe "Get Single Post" do
#       it "return http unauthorized" do
#         get api_board_post_path(@board, @post)
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "return http forbidden" do
#         get api_board_post_path(@board, @post), headers: auth_headers(@user_2)
#         expect(response).to have_http_status(:forbidden)
#       end
#       it "return post" do
#         get api_board_post_path(@board, @post), headers: auth_headers(@user)
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@post))
#       end
#     end

#     describe "Create Post" do
#       it "return http unauthorized" do
#         post api_board_posts_path(@board), as: :json
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "return http forbidden when not owner" do
#         post api_board_posts_path(@board), headers: auth_headers(@user_2), params: valid_attributes, as: :json
#         expect(response).to have_http_status(:forbidden)
#       end
#       it "return http unprocessable_entity when invalid title" do
#         post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         # todo: assert errors
#       end
#       it "return http unprocessable_entity when invalid content" do
#         post api_board_posts_path(@board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         # todo: assert errors
#       end
#       it "successfully creates a post" do
#         board_posts_count = @board.posts.count
#         post api_board_posts_path(@board), headers: auth_headers(@user), params: valid_attributes, as: :json
#         expect(response).to have_http_status(:created)
#         expect(response.body).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@board.posts.last))
#         expect(@board.posts.count).to eq(board_posts_count+1)
#       end
#     end

#     describe "Update Post" do

#       it "return http unauthorized" do
#         put api_board_post_path(@board, @post), as: :json
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "return http forbidden when not owner" do
#         put api_board_post_path(@board, @post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
#         expect(response).to have_http_status(:forbidden)
#       end
#       it "return http unprocessable_entity when invalid title" do
#         put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         # todo: assert errors
#       end
#       it "return http unprocessable_entity when invalid content" do
#         put api_board_post_path(@board, @post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
#         expect(response).to have_http_status(:unprocessable_entity)
#         # todo: assert errors
#       end
#       it "updates my post belonging to my board" do
#         put api_board_post_path(@board, @post), headers: auth_headers(@user), params: valid_attributes, as: :json
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to match_json_schema(:post)
#         expect(body_to_json('title')).to eq(valid_attributes[:title])
#         expect(body_to_json('content')).to eq(valid_attributes[:content])
#       end
#     end

#     describe "Delete Post" do
#       it "return http unauthorized" do
#         delete api_board_post_path(@board, @post)
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "return http forbidden if not owner" do
#         delete api_board_post_path(@board, @post), headers: auth_headers(@user_2)
#         expect(response).to have_http_status(:forbidden)
#       end
#       it "removes my post" do
#         post_id = @post.id
#         board_posts_count = @board.posts.count
#         delete api_board_post_path(@board, @post), headers: auth_headers(@user)
#         expect(response).to have_http_status(:ok)
#         expect(@board.posts.count).to eq(board_posts_count-1)
#         expect(Post.find_by_id(post_id)).to be_nil
#         expect(Comment.where(post_id: post_id)).to be_empty
#       end
#     end
#   end

#   context "Shared Board Posts" do

#     describe "Get all posts" do
#       it "return http unauthorized" do
#         get api_board_posts_path(@shared_board)
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "returns all posts for first user" do
#         get api_board_posts_path(@shared_board), headers: auth_headers(@user)
#         expect(response).to have_http_status(:ok)
#         expect(body_to_json('0')).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@shared_board.posts.all))
#       end
#       it "returns all posts for second user" do
#         get api_board_posts_path(@shared_board), headers: auth_headers(@user_2)
#         expect(response).to have_http_status(:ok)
#         expect(body_to_json('0')).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@shared_board.posts.all))
#       end
#     end

#     describe "Get single post" do
#       it "return http unauthorized" do
#         get api_board_post_path(@shared_board, @shared_post)
#         expect(response).to have_http_status(:unauthorized)
#       end
#       it "renders post resource to first user" do
#         get api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user)
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@shared_post))
#       end
#       it "renders post resource to 2nd user" do
#         get api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user_2)
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to match_json_schema(:post)
#         expect(response.body).to be_json_eql(serialize(@shared_post))
#       end
#     end


#     describe "Create post" do

#       it "return http unauthorized" do
#         post api_board_posts_path(@shared_board), as: :json
#         expect(response).to have_http_status(:unauthorized)
#       end

#       context "Board owner" do
#         it "return http unprocessable_entity when invalid title" do
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "return http unprocessable_entity when invalid content" do
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "successfully creates a post" do
#           board_posts_count = @shared_board.posts.count
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user), params: valid_attributes, as: :json
#           expect(response).to have_http_status(:created)
#           expect(response.body).to match_json_schema(:post)
#           expect(response.body).to be_json_eql(serialize(@shared_board.posts.last))
#           expect(@shared_board.posts.count).to eq(board_posts_count+1)
#         end
#       end

#       context "Board shared user" do
#         it "return http unprocessable_entity when invalid title" do
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: invalid_title_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "return http unprocessable_entity when invalid content" do
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: invalid_content_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "successfully creates a post" do
#           board_posts_count = @shared_board.posts.count
#           post api_board_posts_path(@shared_board), headers: auth_headers(@user_2), params: valid_attributes, as: :json
#           expect(response).to have_http_status(:created)
#           expect(response.body).to match_json_schema(:post)
#           expect(response.body).to be_json_eql(serialize(@shared_board.posts.last))
#           expect(@shared_board.posts.count).to eq(board_posts_count+1)
#         end
#       end

#     end

#     describe "Update my post" do

#       # owner of the post in the board should be able to update it
#       it "return http unauthorized" do
#         put api_board_post_path(@shared_board, @shared_post), as: :json
#         expect(response).to have_http_status(:unauthorized)
#       end

#       context "Post owner" do
#         it "return http unprocessable_entity when invalid title" do
#           put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: invalid_title_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "return http unprocessable_entity when invalid content" do
#           put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: invalid_content_attribute, as: :json
#           expect(response).to have_http_status(:unprocessable_entity)
#           # todo: assert errors
#         end
#         it "updates my post belonging to my board" do
#           put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user), params: valid_attributes, as: :json
#           expect(response).to have_http_status(:ok)
#           expect(response.body).to match_json_schema(:post)
#           @shared_post.reload
#           expect(response.body).to be_json_eql(serialize(@shared_post))
#           expect(body_to_json('title')).to eq(valid_attributes[:title])
#           expect(body_to_json('content')).to eq(valid_attributes[:content])
#         end
#       end

#       # while the shared user should not
#       context "Shared user" do
#         it "cannot update the post" do
#           put api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user_2), params: valid_attributes, as: :json
#           expect(response).to have_http_status(:forbidden)
#           @shared_post.reload
#           expect(@shared_post.title).to_not eq(valid_attributes[:title])
#           expect(@shared_post.content).to_not eq(valid_attributes[:content])
#         end
#       end
#     end

#     describe "Delete my post" do

#       it "return http unauthorized" do
#         delete api_board_post_path(@shared_board, @shared_post)
#         expect(response).to have_http_status(:unauthorized)
#       end

#       describe "Post owner" do
#         it "deletes own post" do
#           board_posts_count = @shared_board.posts.count
#           delete api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user)
#           expect(response).to have_http_status(:ok)
#           expect(@shared_board.posts.count).to eq(board_posts_count-1)
#           expect(Post.find_by_id(@shared_post.id)).to be_nil
#         end
#       end

#       describe "Shared user" do
#         it "return http forbidden" do
#           board_posts_count = @shared_board.posts.count
#           delete api_board_post_path(@shared_board, @shared_post), headers: auth_headers(@user_2)
#           expect(response).to have_http_status(:forbidden)
#           expect(board_posts_count).to eq(@shared_board.posts.count)
#           expect(Post.find_by_id(@shared_post.id)).not_to be_nil
#         end
#       end

#     end
#   end
# end
