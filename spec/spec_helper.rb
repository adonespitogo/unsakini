ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
# require 'rspec/autorun'
require 'byebug'
require 'rb-readline'
require 'factory_girl_rails'
require 'json_spec'
require 'json-schema-rspec'
require 'faker'
require 'database_cleaner'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/concerns/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  # config.order = "random"

  config.include JsonSpec::Helpers
  config.include FactoryGirl::Syntax::Methods


  RSpec.configure do |config|
    config.include JSON::SchemaMatchers
    config.json_schemas[:user] = "spec/schema/user.json"
    config.json_schemas[:board] = "spec/schema/board.json"
    config.json_schemas[:post] = "spec/schema/post.json"
    config.json_schemas[:comment] = "spec/schema/comment.json"
  end


  # http://stackoverflow.com/questions/5608203/rspec-integration-test-not-cleaning-the-database
  # http://stackoverflow.com/questions/29466868/rspec-how-to-clean-the-database-after-each-test

  RSpec.configure do |config|
    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    # config.before(:each, :js => true) do
    #   DatabaseCleaner.strategy = :truncation
    # end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end


end
