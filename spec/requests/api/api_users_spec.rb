require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  before(:all) do
    @user = create(:user)
  end

  describe "GET /api/user/:id" do
    it "returns http unauthorized" do
      get api_user_path(@user)
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user" do
      get api_user_path(@user), headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema(:user)
      expect(response.body).to be_json_eql(serialize(@user))
    end
  end

  describe "GET /api/users/search" do

    before(:all) do
      @user_2 = create(:user)
    end

    it "returns http unauthorized" do
      get api_user_search_path, params: {email: @user_2.email}
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http not_found" do
      get api_user_search_path, params: {email: "#{Faker::Crypto.md5}@gmail.com"}, headers: auth_headers(@user)
      expect(response).to have_http_status(:not_found)
    end

    it "returns http not_found if my email" do
      get api_user_search_path, params: {email: @user.email}, headers: auth_headers(@user)
      expect(response).to have_http_status(:not_found)
    end

    it "returns single user with by email" do
      get api_user_search_path, params: {email: @user_2.email}, headers: auth_headers(@user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema(:user)
      expect(response.body).to be_json_eql(serialize(@user_2))
    end

  end

end
