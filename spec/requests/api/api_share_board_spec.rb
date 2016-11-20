require 'rails_helper'

RSpec.describe "Api::ShareBoard", type: :request do

  before(:all) do
    Timecop.freeze
    user_is_sharing_a_board_scenario
  end

  describe "POST /api/share/board/:id" do

    it "returns http unauthorized status" do
      post(
        api_share_board_path,
        as: :json
      )

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http forbidden status when not board owner" do
      post(
        api_share_board_path,
        headers: auth_headers(@user_2),
        params: @payload,
        as: :json
      )
      expect(response).to have_http_status(:forbidden)
    end

    it "returns http forbidden status when not board owner" do
      post(
        api_share_board_path,
        headers: auth_headers(@user_2),
        params: @payload_wo_posts,
        as: :json
      )
      expect(response).to have_http_status(:forbidden)
    end

    it "returns unprocessable_entity http status if empty payload" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: {},
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable_entity http status if no encrypted_password" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_wo_encrypted_password,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable_entity http status if no shared user ids" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_wo_shared_user_ids,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable_entity http status if contains invalid post" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_w_invalid_post,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable_entity http status if contains invalid comment" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_w_invalid_comment,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end


    it "should successfully share board even if no comments" do |variable|
      user_2_boards_count = @user_2.boards.count
      user_3_boards_count = @user_3.boards.count
      user_4_boards_count = @user_4.boards.count

      prev_post_hash = @post.attributes
      prev_comment_hash = @comment.attributes

      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_wo_comments,
        as: :json
      )

      expect(response).to have_http_status(:ok)
      expect(@user_2.boards.count).to eq(user_2_boards_count+1)
      expect(@user_3.boards.count).to eq(user_3_boards_count+1)
      expect(@user_4.boards.count).to eq(user_4_boards_count+1)

      expect(@post.reload.title).to eq @payload_wo_comments[:posts][0][:title.to_s]
      expect(@post.reload.content).to eq @payload_wo_comments[:posts][0][:content.to_s]

    end


    it "should successfully share board even if no posts" do |variable|
      user_2_boards_count = @user_2.boards.count
      user_3_boards_count = @user_3.boards.count
      user_4_boards_count = @user_4.boards.count

      prev_post_hash = @post.attributes
      prev_comment_hash = @comment.attributes

      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload_wo_posts,
        as: :json
      )

      expect(response).to have_http_status(:ok)
      expect(@user_2.boards.count).to eq(user_2_boards_count+1)
      expect(@user_3.boards.count).to eq(user_3_boards_count+1)
      expect(@user_4.boards.count).to eq(user_4_boards_count+1)

    end

    it "should successfully share valid payload" do |variable|
      user_2_boards_count = @user_2.boards.count
      user_3_boards_count = @user_3.boards.count
      user_4_boards_count = @user_4.boards.count

      prev_post_hash = @post.attributes
      prev_comment_hash = @comment.attributes

      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: @payload,
        as: :json
      )

      expect(response).to have_http_status(:ok)
      expect(@user_2.boards.count).to eq(user_2_boards_count+1)
      expect(@user_3.boards.count).to eq(user_3_boards_count+1)
      expect(@user_4.boards.count).to eq(user_4_boards_count+1)

      expect(@post.reload.title).to eq @payload[:posts][0][:title.to_s]
      expect(@post.reload.content).to eq @payload[:posts][0][:content.to_s]
      expect(@comment.reload.content).to eq @payload[:posts][0][:comments][0][:content.to_s]

    end

  end

end
