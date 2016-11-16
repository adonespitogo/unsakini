require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  it "renders app/index.html" do
    get :app
    expect(response.body).to match File.read(Rails.public_path.join("app","index.html"))
  end

end
