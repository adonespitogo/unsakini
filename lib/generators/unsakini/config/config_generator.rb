class Unsakini::ConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def initialize_config_options
    copy_file "unsakini.rb", "config/initializers/unsakini.rb"
    environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'
    environment 'config.action_mailer.default_url_options = { :host => "localhost:3000" }', env: 'development'
    application \
          "config.middleware.insert_before 0, 'Rack::Cors' do
           allow do
             origins '*'
             resource '*', :headers => :any, :methods => [:get, :post, :options]
           end
         end"
  end
end
