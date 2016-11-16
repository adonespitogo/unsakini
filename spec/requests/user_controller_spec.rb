require 'rails_helper'

RSpec.describe Api::UserController, type: :controller do

  before(:all) do
    @user = create(:user)
  end

  describe "GET #show" do
    it "returns http unauthorized" do
      get :show, params: {id: @user.id}
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns current user" do
      sign_in(@user)
      get :show, params: {id: @user.id}
      expect(response.body).to look_like_json
      expect(body_as_json).to match(json_str_to_hash(@user.to_json))
    end
  end
end
