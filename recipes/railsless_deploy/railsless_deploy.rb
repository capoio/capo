##################################################
###### Begin sets

###### End sets
##################################################

begin
  require 'railsless-deploy'
rescue LoadError => e
  raise "\nrailsless-deploy gem not found. Either install it with '(sudo) gem install railsless-deploy' of if you are using bundler add it to your gemfile."
end
