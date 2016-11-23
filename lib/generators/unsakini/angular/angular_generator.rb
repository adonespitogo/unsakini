class Unsakini::AngularGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../../', __FILE__)

  def copy_initializer_file
    directory 'angular', 'angular'
  end
end
