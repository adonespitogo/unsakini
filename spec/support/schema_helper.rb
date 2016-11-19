RSpec.configure do |config|
  config.include JSON::SchemaMatchers
  config.json_schemas[:board] = "spec/schema/board.json"
  config.json_schemas[:user] = "spec/schema/user.json"
end