##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'bundler/capistrano'
rescue LoadError => e
  raise "\nbundler gem not found. Please install it with '(sudo) gem install bundler'."
end
