begin
  require 'new_relic/recipes'
rescue LoadError
  $stderr.puts <<INSTALL
You need the newrelic gem to deploy this application
Install the gem like this:
  gem install newrelic
INSTALL
  exit 1
end


set :newrelic_appname, "YOUR_APP_NAME"
after "deploy:update", "newrelic:notice_deployment"
