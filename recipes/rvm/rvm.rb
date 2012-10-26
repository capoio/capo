##################################################
###### Begin sets

set :rvm_ruby_string, 'my-ruby@my-gemset'

###### End sets
##################################################

begin
  require 'rvm/capistrano'
rescue LoadError
  raise "\nrvm-capistrano gem not found. Either install it with '(sudo) gem install rvm-capistrano' or add it to your Gemfile if you are using bundler."
end
