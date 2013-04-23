##################################################
###### Begin sets

begin
  require 'new_relic/recipes'
rescue LoadError
  raise "\nnewrelic_rpm gem not found. Please install it with '(sudo) gem install newrelic_rpm'."
end

set :newrelic_appname, "YOUR_APP_NAME"

###### End sets
##################################################

after "deploy:update", "newrelic:notice_deployment"
