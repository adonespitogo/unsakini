require 'rails_helper'

RSpec.describe "Api::Board::Posts", type: :request do
  describe "GET /api_board_posts" do
    it "works! (now write some real specs)" do
      get api_board_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
