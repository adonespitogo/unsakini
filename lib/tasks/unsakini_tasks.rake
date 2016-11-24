namespace :unsakini do


  desc "Runs `rails generate unsakini:config`"
  task :config do
    begin
      Dir.chdir Rails.root do
        system('bin/rails g unsakini:config')
      end
    rescue Exception => e
      puts "

      Please run `bin/rails g unsakini:config` before you proceed.

      "
    end
  end

  desc "Installs the Angular 2 web client to public/app"
  task :ng2 do
    repo_name = "https://github.com/unsakini/unsakini-ng2"
    tmp_dir = "#{Rails.root}/tmp/unsakini-ng2"
    app_dir = "#{Rails.root}/public/app/"
    begin
      Dir.chdir Rails.root do
        system("rm -rf #{tmp_dir} #{app_dir}")
        system("git clone #{repo_name} #{tmp_dir}")
        system("mv #{tmp_dir}/dist #{app_dir}")
      end
    rescue Exception => e
      puts e.to_s
      raise "

      Please clone #{repo_name} and extract dist folder to your projects public/app folder

      "
    end
  end

  desc "One stop command to install unsakini."
  task :install => [:config, :ng2] do
    begin
      Dir.chdir "#{Rails.root}" do
        system("#{Rails.root}/bin/rake unsakini_engine:install:migrations")
        system("#{Rails.root}/bin/rake db:migrate")
      end
    rescue Exception => e
      puts e.to_s
      puts \
      "
        
        An error occured. Please run the following commands in succession:

        "
      puts "1.) rails g unsakini:config"
      puts "2.) rails g unsakini:angular"
      puts "3.) bundle exec rake unsakini_engine:install:migrations"
      puts "4.) bundle exec rake db:migrate"
      puts ""
    end
  end




end
