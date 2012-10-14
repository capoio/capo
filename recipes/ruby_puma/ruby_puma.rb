##################################################
###### Begin sets

###### End sets
##################################################

namespace :puma do
  desc 'Restart the web server'
  task :restart, :roles => :app do
    run "kill -s USR2 `cat /tmp/capo.pid `"
  end

  desc 'Stop the web server'
  task :stop, :roles => :app do
    run 'kill -9 `cat /tmp/capo.pid`'
  end

  desc 'Start the web server'
  task :start, :roles => :app do
    run 'cd /home/capo/capo && /usr/bin/puma --pidfile /tmp/capo.pid -e production -b unix:///tmp/sockets/capo.sock 2>&1 >> /home/capo/logs/capo.log'
  end
end

namespace :deploy do
  desc 'Restart your application'
  task :restart do
    puma::restart
  end
end
