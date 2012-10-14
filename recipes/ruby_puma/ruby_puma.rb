##################################################
###### Begin sets

set :application_directory, 'application_directory'


###### End sets
##################################################

namespace :puma do
  desc 'Restart the web server'
  task :restart, :roles => :app do
    run "kill -s USR2 `cat /tmp/#{application}.pid `"
  end

  desc 'Stop the web server'
  task :stop, :roles => :app do
    run 'kill -9 `cat /tmp/#{application}.pid`'
  end

  desc 'Start the web server'
  task :start, :roles => :app do
    run 'cd #{application_directory} && puma --pidfile /tmp/#{application}.pid -e production -b unix:///tmp/sockets/#{application}.sock 2>&1 >> #{application_directory}/logs/capo.log'
  end
end

namespace :deploy do
  desc 'Restart your application'
  task :restart do
    puma::restart
  end
end
