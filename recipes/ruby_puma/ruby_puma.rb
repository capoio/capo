##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'puma/capistrano'
rescue LoadError
  raise "\npuma gem not found. Please install it with '(sudo) gem install puma'."
end
