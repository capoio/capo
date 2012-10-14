##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'airbrake/capistrano'
rescue LoadError => e
  raise "\nairbrake gem not found. Please install it with '(sudo) gem install airbrake'."
end
