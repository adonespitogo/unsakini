
module AuthHelper

  def auth_headers(user)
  	# debugger
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Authorization': "Bearer #{token}"
    }
  end

end

RSpec.configure do |config|
  config.include AuthHelper
end
