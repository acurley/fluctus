# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

task :ci => ['jetty:clean', 'fluctus:travis']
task :default => [:ci]

Fluctus::Application.load_tasks
