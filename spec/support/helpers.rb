module Helpers
  def auth_headers(user)
    user.create_new_auth_token.merge!(json_request_headers)
  end

  def json_request_headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  def body_as_json
    json_str_to_hash(response.body)
  end

  def json_str_to_hash(str)
    JSON.parse(str).with_indifferent_access
  end
end

RSpec.configure do |config|
  config.include Helpers
end