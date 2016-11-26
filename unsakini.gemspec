$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "unsakini/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unsakini"
  s.version     = Unsakini::VERSION
  s.authors     = ["Adones Pitogo"]
  s.email       = ["pitogo.adones@gmail.com"]
  s.homepage    = "http://github.com/adonespitogo/unsakini"
  s.summary     = \
    "Open source ruby BB created by and for online activists, information security enthusiasts and government surveillance evaders."
  s.description = \
    "Unsakini is an open source encrypted bulletin board created with the aim of evading 
    global information surveillance and spying, preventing data leaks and promoting information confidentiality and integrity."
  s.license     = "MIT"
  s.required_ruby_version = '>= 2.2.2'
  s.requirements << 'rails, >= 5.0'

  s.files = Dir["{angular,app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"].reject do |path|
      !(path =~ /node_modules/).nil? or !(path =~ /e2e/).nil?
    end

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "active_model_serializers"
  s.add_dependency "rack-cors"
  s.add_dependency "kaminari"
  s.add_dependency "api-pagination"
  s.add_dependency "devise_token_auth"
  s.add_dependency "omniauth"

  s.add_development_dependency "sqlite3"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  s.add_development_dependency 'byebug'
  # Needed to use debugger
  # https://github.com/deivid-rodriguez/byebug/issues/289
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'json_spec'
  s.add_development_dependency 'json-schema-rspec'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'letter_opener'

  s.test_files = Dir["spec/**/*"].reject do |path|
      !(path =~ /node_modules/).nil? or
      !(path =~ /log/).nil?
    end

end
