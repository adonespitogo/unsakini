require 'rails_helper'

RSpec.describe "Unsakini::Boards", type: :request do

  before(:each) do
    boards_pagination_scenario
  end

  let(:num_per_page) {
    10
  }


  describe "Pagination" do

    context "Private Boards" do

      describe "GET /unsakini/boards" do

        it "returns current user's boards" do
          get unsakini_boards_path, params: {page: 1}, headers: auth_headers(@user)
          expect(response).to have_http_status(:ok)
          expect(body_to_json.count).to eq num_per_page
          expect(body_to_json('0')).to match_json_schema(:board)
          expect(get_header("Total").to_i).to eq @num_boards
        end

        it "returns current user's boards last page" do
          get unsakini_boards_path, params: {page: 2}, headers: auth_headers(@user)
          expect(response).to have_http_status(:ok)
          expect(body_to_json.count).to eq @num_boards - num_per_page
          expect(body_to_json('0')).to match_json_schema(:board)
          expect(get_header("Total").to_i).to eq @num_boards
        end

      end

    end

    context "My Shared Boards" do

      describe "GET /unsakini/boards, admin = true" do

        it "returns current user's shared boards" do
          get unsakini_boards_path, params: {page: 1, admin: true, shared: true}, headers: auth_headers(@user)
          expect(response).to have_http_status(:ok)
          expect(body_to_json.count).to eq num_per_page
          expect(body_to_json('0')).to match_json_schema(:board)
          expect(get_header("Total").to_i).to eq @num_my_shared_boards
        end

        it "returns current user's boards last page" do
          get unsakini_boards_path, params: {page: 2, admin: true, shared: true}, headers: auth_headers(@user)
          expect(response).to have_http_status(:ok)
          expect(body_to_json.count).to eq @num_my_shared_boards - num_per_page
          expect(body_to_json('0')).to match_json_schema(:board)
          expect(get_header("Total").to_i).to eq @num_my_shared_boards
        end

      end

    end

  end


end
