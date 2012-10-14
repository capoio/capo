set :whenever_command, "bundle exec whenever"

begin
  require 'whenever'
rescue LoadError => e
  raise "\nwhenever gem not found. Either install it with '(sudo) gem install whenever' of if you are using bundler add it to your gemfile."
end
