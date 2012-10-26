##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'railsless-deploy'
rescue LoadError
  raise "\nrailsless-deploy gem not found. Either install it with '(sudo) gem install railsless-deploy' or add it to your Gemfile if you are using bundler."
end
