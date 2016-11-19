require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  before(:all) do
    Timecop.freeze
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
end
