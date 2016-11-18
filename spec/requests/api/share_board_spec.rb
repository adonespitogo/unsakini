require 'rails_helper'

RSpec.describe "Api::ShareBoard", type: :request do

  before(:all) do
    Timecop.freeze
    @user = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
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
                        post_id: @post.id,
    })
  end

  let(:payload) {
    pl = {
      board: @board.attributes,
      posts: [
        @post.attributes
      ]
    }

    pl[:posts][0][:comments] = [@comment.attributes]
    pl[:shared_user_ids] = [@user_2.id, @user_3.id]
    pl[:encrypted_password] = 'secret'
    pl
  }

  let(:payload_wo_comments) {
    pl = payload.dup
    pl[:posts][0].tap { |hs| hs.delete(:comments) }
    pl
  }

  let(:payload_wo_encrypted_password) {
    pl = payload
    pl.tap { |hs| hs.delete(:encrypted_password) }
    pl
  }
  let(:payload_wo_shared_user_ids) {
    pl = payload
    pl.tap { |hs| hs.delete(:shared_user_ids) }
    pl
  }

  let(:payload_w_invalid_post) {
    pl = payload
    invalid_post = create(:post)
    pl[:posts] = [create(:post).attributes]
  }

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
        params: payload,
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
        params: payload_wo_encrypted_password,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "returns unprocessable_entity http status if no shared user ids" do
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: payload_wo_shared_user_ids,
        as: :json
      )
      expect(response).to have_http_status(:unprocessable_entity)
    end


    it "should successfully share board even if no comments" do |variable|
      post(
        api_share_board_path,
        headers: auth_headers(@user),
        params: payload_wo_comments,
        as: :json
      )
      expect(response).to have_http_status(:ok)

    end

  end
end
