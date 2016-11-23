namespace :unsakini do

  desc "One stop command to build unsakini."

  task :install do
    begin
      Dir.chdir Rails.root do
        system('bin/rails g unsakini:config')
        system('bin/rails g unsakini:angular')
        Rake::Task['unsakini:build'].invoke
        Rake::Task['unsakini_engine:install:migrations'].invoke
        Rake::Task['db:migrate'].invoke
      end
    rescue Exception => e
    	puts e.to_s
    	puts \
    		"
    		
    		An error occured. Please run the following commands in succession:

    		"
    	puts "1.) bin/rails g unsakini:config"
    	puts "2.) bin/rails g unsakini:angular"
    	puts "3.) rake unsakini_engine:install:migrations"
    	puts "4.) rake db:migrate"
    end
  end

end
