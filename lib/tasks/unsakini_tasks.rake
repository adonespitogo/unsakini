namespace :unsakini do

  desc "Initializes the angular app in ./angular directory."
  task :install do

    ng_dir = 'angular'
    lib_dir = "#{File.expand_path File.dirname(__FILE__)}"
    lib_dir.slice!("/lib/tasks")

    puts "Removing old angular files in #{Rails.root}/#{ng_dir}"
    FileUtils.rm_rf("#{Rails.root}/#{ng_dir}")
    FileUtils.mkdir_p "#{Rails.root}/#{ng_dir}"
    puts "Copying angular app sources to #{Rails.root}/#{ng_dir}"
    FileUtils.cp_r "#{lib_dir}/#{ng_dir}/", Rails.root

    puts "Building the angular application to #{Rails.root}/app"

    Dir.chdir "#{Rails.root}/#{ng_dir}" do
      puts "Changed working directory to #{Dir.pwd}"
      cmd = ''
      cmd += 'npm i;'
      cmd += "#{Rails.root}/#{ng_dir}/node_modules/.bin/ng build"
      cmd += " --prod" if Rails.env.production?
      puts "Running #{cmd}"
      system(cmd)

      puts "Copying the crypto.yml config file to #{Rails.root}/config/"
      FileUtils.cp "#{lib_dir}/config/crypto.yml", "#{Rails.root}/config"

      puts \
        "

        Done! Now run the migrations by typing `rake db:migrate`.
        
        Start the local server by typing `rails server`.
        
        Then browse to http://localhost:3000 to see the running application.


        "
    end
  end

end
