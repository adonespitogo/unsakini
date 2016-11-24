require 'rails_helper'

RSpec.describe "Api::Board::Post::Comments", type: :request do

  before(:all) do
    post_has_many_comments_scenario
  end

  let(:num_per_page) {
    20
  }

  describe "Pagination" do

    it "returns first 20 comments" do
      get api_board_post_comments_path(@board, @post), headers: auth_headers(@user), params: {page: 1}
      expect(body_to_json.count).to eq num_per_page
      expect(body_to_json('0')).to match_json_schema(:comment)
      expect(get_header("Total").to_i).to eq @num_comments
    end

    it "returns last page" do
      get api_board_post_comments_path(@board, @post), headers: auth_headers(@user), params: {page: 2}
      expect(body_to_json('0')).to match_json_schema(:comment)
      expect(get_header("Total").to_i).to eq @num_comments
      expect(body_to_json.count).to eq @num_comments - num_per_page
    end

  end

end
