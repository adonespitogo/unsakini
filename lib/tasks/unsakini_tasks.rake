namespace :unsakini do

  desc "Initializes the angular app in ./angular directory."
  task :install do

    ng_dir = 'angular'

    # clean app angular dir
    puts "Removing old version of unsakini app in #{Rails.root}/#{ng_dir}"
    FileUtils.rm_rf("#{Rails.root}/#{ng_dir}")
    # copy angular sources
    puts "Copying angular sources to #{Rails.root}/#{ng_dir}"
    FileUtils.copy_entry 'angular', "#{Rails.root}/#{ng_dir}"
    # npm install
    puts "Building the angular app"
    Dir.chdir "#{Rails.root}/#{ng_dir}" do
      cmd = ''
      cmd += 'npm i angular-cli;'
      cmd += 'npm i;'
      cmd += "#{Rails.root}/angular/node_modules/.bin/ng build"
      cmd += " --prod" if Rails.env.production?
      system(cmd)
    end
  end

end
