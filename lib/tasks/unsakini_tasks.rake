namespace :unsakini do


  desc "Runs `rails generate unsakini:config`"
  task :config do
    puts "Generating config file ..."
    system('bundle exec rails g unsakini:config')
    puts "Done."
  end

  desc "Prepares the web client assets"
  task :client do
    tmp_dir = "#{Rails.root}/tmp/unsakini-ng2"
    extract_dir = "#{Rails.root}/public/app"
    begin
      system("rm -rf #{tmp_dir} #{extract_dir}")
      puts "\nCloning the web client. Please wait ...\n"
      system("git clone https://github.com/unsakini/unsakini-ng2.git #{tmp_dir} -q")
      system("mv #{Rails.root}/tmp/unsakini-ng2/dist #{extract_dir}")
      puts "Done.\n"
    rescue Exception => e
      puts e.to_s

      puts \
        "Unable to clone remote git repository.
        Please clone https://github.com/unsakini/unsakini-ng2.git and extract the `dist` folder into your project's `public/app` folder."
        end
  end

  desc "One stop command to install unsakini."
  task :install => [:client, :config] do
    begin
      puts "\nGenerating migration files...\n"
      system('bundle exec rake unsakini_engine:install:migrations')
      puts "\nRunning the migration files ...\n\n"
      system('bundle exec rake db:migrate')
      puts "Done.

      Now, run the rails server to see the working Unsakini application.

      Type `bundle exec rails server`

      Then browse to http://localhost:3000

      "
    rescue Exception => e
      puts e.to_s
      puts \
      "
        
        An error occured. Please run the following commands in succession:

        "
      puts "1.) rails g unsakini:client"
      puts "2.) rails g unsakini:config"
      puts "3.) bundle exec rake unsakini_engine:install:migrations"
      puts "4.) bundle exec rake db:migrate"
      puts ""
    end
  end




end
