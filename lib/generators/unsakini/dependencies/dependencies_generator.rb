class Unsakini::DependenciesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def add_dependencies_to_host
    gem "active_model_serializers"
    gem "rack-cors"
    gem "kaminari"
    gem "api-pagination"
    gem "bcrypt"
    gem 'jwt'
  end
end
