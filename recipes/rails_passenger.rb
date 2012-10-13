configs do
  description 'Passenger actions'
  version 0.1
  tags %w[rails passenger]
  category 'rails'
  dependencies %w[]
end

namespace :passenger do
  desc 'Restart the web server'
  task :restart, :roles => :app do
    run "touch  #{deploy_to}/current/tmp/restart.txt"
  end
end
