require 'rails_helper'

describe 'catch html5 pushState routes' do
  it 'get /app/any renders app/index.html' do
    get '/app/any'
    expect(response.body).to match File.read(Rails.public_path.join("app","index.html"))
  end
end
