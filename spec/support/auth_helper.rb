module AuthHelper

  def auth_headers(user)
    user.create_new_auth_token
  end

end

RSpec.configure do |config|
  config.include AuthHelper
end
