require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  before(:all) do
    @user = create(:user)
  end

  let(:valid_attributes) {
    {
      name: Faker::Name.name_with_middle,
      email: "#{Faker::Internet.email}",
      password: "12345678",
      password_confirmation: "12345678"
    }
  }

  let(:invalid_name) {
    {
      name: "",
      email: "#{Faker::Internet.email}",
      password: "12345678",
      password_confirmation: "12345678"
    }

  }

  let(:invalid_email) {
    {
      name: Faker::Name.name_with_middle,
      email: "asdf",
      password: "12345678",
      password_confirmation: "12345678"
    }

  }

  let(:invalid_password) {
    {
      name: Faker::Name.name_with_middle,
      email: "#{Faker::Internet.email}",
      password: "123",
      password_confirmation: "12345678"
    }

  }

  let(:invalid_password_confirmation) {
    {
      name: Faker::Name.name_with_middle,
      email: "",
      password: "12345678",
      password_confirmation: "asdfasdf"
    }

  }

  describe "Create User" do

    it "rejects invalid name" do
      prev_user_count = User.count
      post api_user_path, params: invalid_name, as: :json
      expect(response).to have_http_status 422
      expect(User.count).to eq prev_user_count
    end

    it "rejects invalid email" do
      prev_user_count = User.count
      post api_user_path, params: invalid_email, as: :json
      expect(response).to have_http_status 422
      expect(User.count).to eq prev_user_count
    end

    it "rejects invalid password" do
      prev_user_count = User.count
      post api_user_path, params: invalid_password, as: :json
      expect(response).to have_http_status 422
      expect(User.count).to eq prev_user_count
    end

    it "rejects invalid password_confirmation" do
      prev_user_count = User.count
      post api_user_path, params: invalid_password_confirmation, as: :json
      expect(response).to have_http_status 422
      expect(User.count).to eq prev_user_count
    end

    it "creates the user" do
      prev_user_count = User.count
      post api_user_path, params: valid_attributes, as: :json
      expect(response).to have_http_status :created
      expect(response.body).to match_json_schema :user
      expect(User.count).to eq prev_user_count+1
    end

  end

end
