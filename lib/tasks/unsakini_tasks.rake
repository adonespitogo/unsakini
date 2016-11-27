namespace :unsakini do

  desc "One stop command to install unsakini."
  task :install do
    begin
      Dir.chdir "#{Rails.root}" do
        system("#{Rails.root}/bin/rails g unsakini:config")
        system("#{Rails.root}/bin/rake unsakini_engine:install:migrations")
        system("#{Rails.root}/bin/rake db:migrate")
        system("#{Rails.root}/bin/rails g unsakini:dependencies")
      end
    rescue Exception => e
      puts e.to_s
      puts \
      "
        An error occured. Please run the following commands in succession:

        "
      puts "1.) rails g unsakini:config"
      puts "2.) rails g unsakini:dependencies"
      puts "3.) bundle exec rake unsakini_engine:install:migrations"
      puts "4.) bundle exec rake db:migrate"
      puts ""
    end
  end




end
