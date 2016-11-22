namespace :ng do
	
  desc "Install angular dependencies"
  task install: :environment do
  	cmd = 'cd angular;'
  	cmd += 'npm i angular-cli gulp;'
  	cmd += 'npm i'
  	system(cmd)
  end

  desc "Build the frontend angular app"
  task build: :environment do
  	cmd = 'cd angular;'
  	cmd += 'node_modules/.bin/ng build'
  	cmd += ' --prod' if Rails.env.production?
  	system(cmd)
  end

end
