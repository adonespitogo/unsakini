namespace :unsakini do


  desc "Runs `rails generate unsakini:config`"
  task :config do
    system('bundle exec rails g unsakini:config')
  end

  desc "Runs `rails generate unsakini:angular`"
  task :angular do
    system('bundle exec rails g unsakini:angular')
  end

  desc "Initializes the angular app in ./angular directory."
  task :build do

    ng_dir = 'angular'
    lib_dir = "#{File.expand_path File.dirname(__FILE__)}"
    lib_dir.slice!("/lib/tasks")

    begin
      Dir.chdir "#{Rails.root}/#{ng_dir}" do

        cmd = ''
        cmd += 'npm i;'
        cmd += "#{Rails.root}/#{ng_dir}/node_modules/.bin/ng build"
        cmd += " --prod" if Rails.env.production?
        puts "Running #{cmd}"
        system(cmd)

        puts "Done installing angular assets."
      end
    rescue Exception => e
      puts \
      "

        Please run `rails g unsakini:angular` before you proceed.

        "
    end

  end

  desc "One stop command to install unsakini."
  task :install => [:config] do
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
