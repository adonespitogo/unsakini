namespace :unsakini do

  desc "Initializes the angular app in ./angular directory."
  task :install do
    cmd = "cp -r angular #{Rails.root};"
    cmd += "cd #{Rails.root}/angular;"
    cmd += 'npm i angular-cli;'
    cmd += 'npm i;'
    cmd += "#{Rails.root}/angular/node_modules/.bin/ng build"
    cmd += " --prod" if Rails.env.production?
    system(cmd)
  end

  # desc "test"
  # task :test do
  #   dirs = Dir["{angular,app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"].reject do |path|
  #     !(path =~ /node_modules/).nil?
  #   end

  #   puts dirs
  # end

end
