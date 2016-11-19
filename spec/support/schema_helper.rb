RSpec.configure do |config|
  config.include JSON::SchemaMatchers
  config.json_schemas[:board] = "spec/schema/board.json"
end