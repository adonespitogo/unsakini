module Helpers
  def sign_in(user)
    request.headers.merge!(user.create_new_auth_token)
    set_json_request_headers
  end

  def set_json_request_headers
    request.headers.merge!({'Content-Type' => 'application/json'})
    request.headers.merge!({'Accept' => 'application/json'})
  end

  def body_as_json
    json_str_to_hash(response.body)
  end

  def json_str_to_hash(str)
    JSON.parse(str).with_indifferent_access
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :controller
end