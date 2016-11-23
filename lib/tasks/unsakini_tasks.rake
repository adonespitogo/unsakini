namespace :unsakini do

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

end
