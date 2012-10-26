##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'airbrake/capistrano'
rescue LoadError
  raise "\nairbrake gem not found. Please install it with '(sudo) gem install airbrake' or add it to your Gemfile if you are using bundler."
end
