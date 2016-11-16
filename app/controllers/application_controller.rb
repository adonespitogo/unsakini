class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def app
    render file: Rails.public_path.join("app","index.html")
  end
end
