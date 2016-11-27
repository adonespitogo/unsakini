require 'rails_helper'

# test scope is @user is owner of the board and owner of the post/s
RSpec.describe "Usakini::Board::Posts", type: :request do

  before(:each) do
    user_has_many_posts_scenario
  end

  let(:num_per_page) {
    20
  }

  describe "Get Posts" do

    it "return posts" do
      get unsakini_board_posts_path(@board), headers: auth_headers(@user), params: {page: 1}
      expect(response).to have_http_status(:ok)
      expect(body_to_json.count).to eq num_per_page
      expect(body_to_json('0')).to match_json_schema(:post)
      expect(get_header("Total").to_i).to eq @num_posts
    end

    it "return last page" do
      get unsakini_board_posts_path(@board), headers: auth_headers(@user), params: {page: 2}
      expect(response).to have_http_status(:ok)
      expect(body_to_json.count).to eq @num_posts - num_per_page
      expect(body_to_json('0')).to match_json_schema(:post)
      expect(get_header("Total").to_i).to eq @num_posts
    end

  end

end
