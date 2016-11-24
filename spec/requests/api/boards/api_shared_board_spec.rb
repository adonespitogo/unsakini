require 'rails_helper'

RSpec.describe "Api::Boards", type: :request do

  let(:valid_board_params) {
    {
      :board => {:name => "board name"},
      :encrypted_password => Faker::Crypto.md5
    }
  }
  let(:invalid_board_name_param) {
    {
      :board => {:name => nil},
      :encrypted_password => Faker::Crypto.md5
    }
  }
  let(:invalid_encrypted_password_param) {
    {
      :board => {:name => "board name"},
      :encrypted_password => nil
    }
  }

  context "Shared Board" do

    before(:each) do
      user_has_shared_board_scenario
    end

    describe "GET /api/boards/:id" do

      it "returns http unauthorized" do
        get api_board_path(@shared_board)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns board resource" do
        get api_board_path(@shared_board), headers: auth_headers(@user_2)
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema(:board)
        expect(response.body).to be_json_eql(serialize(@shared_user_board_2))
      end
    end

    describe "PUT /api/boards/:id" do
      it "updates the board resource" do
        put api_board_path(@shared_board), params: valid_board_params, headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
        @shared_board.reload
        expect(@shared_board.name).not_to eq(valid_board_params[:board][:name])
        expect(@shared_user_board_2.encrypted_password).not_to eq(valid_board_params[:encrypted_password])
      end
    end

    describe "DELETE /api/boards/:id" do

      it "returns http forbidden if not board owner" do
        delete api_board_path(@shared_board), headers: auth_headers(@user_2), as: :json
        expect(response).to have_http_status(:forbidden)
        expect(Board.find(@shared_board.id)).not_to be_nil
      end
    end

  end

end
