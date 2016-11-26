class Unsakini::ConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    copy_file "unsakini.rb", "config/initializers/unsakini.rb"
    run 'rails generate knock:install'
  end
end
