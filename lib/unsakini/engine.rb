require "unsakini/version"

module Unsakini
  class Engine < ::Rails::Engine

    # initializer "static assets" do |app|
    #   app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    # end

    config.generators.api_only = true
    config.unsakini_crypto_key = 'secret'

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

  end

  # http://stackoverflow.com/questions/4065699/rails-3-engine-provide-config-for-users
  def self.setup(&block)
    yield Engine.config if block
    Engine.config
  end

end
