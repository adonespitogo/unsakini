$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "unsakini/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unsakini"
  s.version     = Unsakini::VERSION
  s.authors     = ["Adones Pitogo"]
  s.email       = ["pitogo.adones@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = "Summary of Unsakini."
  s.description = "Description of Unsakini."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "active_model_serializers"
  s.add_dependency 'bcrypt', '~> 3.1.7'
  s.add_dependency "knock"
  s.add_dependency "rack-cors"

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

  s.test_files = Dir["spec/**/*"]

end
