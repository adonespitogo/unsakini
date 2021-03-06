class Unsakini::DependenciesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def add_dependencies_to_host

    gem 'active_model_serializers'
    gem 'rack-cors', require: 'rack/cors'
    gem 'kaminari'
    gem 'api-pagination'
    gem 'knock', git: 'https://github.com/adonespitogo/knock'

    gem_group :development, :test do
      gem "rb-readline"
      gem "byebug"
      gem 'letter_opener'
    end

  end
end
