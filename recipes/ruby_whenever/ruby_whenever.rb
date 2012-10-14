##################################################
###### Begin sets

set :whenever_command, "bundle exec whenever"

###### End sets
##################################################

begin
  require 'whenever/capistrano'
rescue LoadError => e
  raise "\nwhenever gem not found. Either install it with '(sudo) gem install whenever' or add it to your Gemfile if you are using bundler."
end
