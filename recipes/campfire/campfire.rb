##################################################
###### Begin sets
begin
  require 'capistrano/campfire'
rescue LoadError
  raise "\ncapistrano-campfire gem not found. Please install it with '(sudo) gem install capistrano-campfire' or add it to your Gemfile if you are using bundler."
end

set :campfire_options, :account => 'account', :room => 'Fail', :token => 'edb0b0958f1a7f26e8fe270db8834ac301fb337c', :ssl => true
###### End sets
##################################################

namespace :campfire do
  desc "Send message to Campfire after succesfull deploy"
  task :deploy, :except => { :no_release => true } do
    rails_env = fetch(:rails_env, "production")
    local_user = ENV['USER'] || ENV['USERNAME']
    campfire_room.speak "Hooray, #{local_user} deployed #{application.capitalize} to #{rails_env} commit: #{current_revision[0..5]}"
  end
end

after "deploy",            "campfire:deploy"
after "deploy:migrations", "campfire:deploy"
