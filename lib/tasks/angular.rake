namespace :ng do

  desc "Install angular dependencies"
  task install: :environment do
  	command = "cd angular;"
  	command += "npm i angular-cli gulp;"
  	command += "npm i"
  	command += "cd ..; rake ng:build"
  	system(command)
  end

  desc "Build the angular app"
  task build: :environment do
  	command = "cd angular;"
  	command += 'node_modules/.bin/ng build'
  	command += ' --prod;' if Rails.env.production?
  	system(command)
  end

end
