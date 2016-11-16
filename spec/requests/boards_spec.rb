require 'rails_helper'

RSpec.describe "Boards API", type: :request do

  before(:all) do
    @user = create(:user)
  end

  describe "GET /api/boards" do
    it "returns http unauthorized" do
      get api_boards_path
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns boards" do
      pending ""
      throw
      # get api_boards_path, params: nil, headers: auth_headers(@user)
      # expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/boards"
end
