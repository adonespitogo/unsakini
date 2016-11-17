require 'rails_helper'

RSpec.describe "User API", type: :request do

  before(:all) do
    @user = create(:user)
  end

  describe "GET /api/user/:id" do
    it "returns http unauthorized" do
      get api_user_path(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user" do
      get api_user_path(@user), params: nil, headers: auth_headers(@user)
      expect(response.body).to look_like_json
      expect(body_as_json).to equal_model_hash(@user)
    end
  end
end
