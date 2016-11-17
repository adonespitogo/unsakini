namespace :yardoc do
  task :backend do
    sh "yardoc --output-dir public/docs/backend"
  end
end
