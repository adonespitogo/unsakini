require 'json_web_token'

module AuthHelper

  def auth_headers(user)
    {
      'Authorization': "Bearer #{JsonWebToken.encode({user_id: user.id})}",
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  end

end

RSpec.configure do |config|
  config.include AuthHelper
end
