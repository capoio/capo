configs do
  description 'Default capistrano settings.'
  version 0.1
  tags %w[capistrano default configs]
  category 'defaults'
  dependencies %w[]
end

# Set the user of your application
set :user, 'account_user'

#Set the application name on the server
set :application, 'application_name'

# Set the name of your branch
set :branch, :master

# The amount of release you want to keep
set :keep_releases, 3

# Do you deploy as a sudo user
set :use_sudo, false

# Set true if you deploy to a shared environment
set :group_writable, false

set :deploy_via, :remote_cache

# Must be set for the password prompt from git to work
default_run_options[:pty] = true

# Where do you want to deploy
set(:deploy_to) {"/home/#{user}/apps/#{application}"}

# Default action to clean older versions
after :deploy, 'deploy:cleanup'
