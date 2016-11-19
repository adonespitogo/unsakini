RSpec.configure do |config|
  config.include JsonSpec::Helpers
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
end