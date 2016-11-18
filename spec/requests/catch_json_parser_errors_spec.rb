require 'rails_helper'

RSpec.describe "CatchJsonParserErrors", type: :request do
  describe "POST /api/boards with malformed json params" do
    it "return http bad_request" do
      @user = create(:user)
      post api_boards_path, params: {}, headers: auth_headers(@user)
      expect(response).to have_http_status(:bad_request)
    end
    it "return http bad_request" do
      @user = create(:user)
      post api_boards_path, params: {name: "test"}, headers: auth_headers(@user), as: :json
      expect(response).to have_http_status(:created)
    end
  end
end
