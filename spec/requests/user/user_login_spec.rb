require 'rails_helper'

RSpec.describe "Unsakini::Users", type: :request do

  before(:all) do
    @user = create(:user)
  end

  describe "Login" do

    it "returns http not_found" do
      post unsakini_user_token_path, params: {auth: {email: Faker::Internet.email}}
      expect(response).to have_http_status(:not_found)
    end

    it "returns http not_found" do
      post unsakini_user_token_path, params: {auth: {email: @user.email, password: 'incorrect'}}
      expect(response).to have_http_status(:not_found)
    end

    it "returns http unauthorized" do
      post unsakini_user_token_path, params: {auth: {email: @user.email, password: @user.password}}
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns jwt token" do
      @user.confirmed_at = Time.now.utc
      @user.save
      post unsakini_user_token_path, params: {auth: {email: @user.email, password: @user.password}}
      expect(response).to have_http_status(:created)
      expect(response.body).to match_json_schema(:jwt)
    end

  end

end
