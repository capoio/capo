##################################################
###### Begin sets

unless exists?(:daemons)
  set :daemons, [:dameon_name]
end

###### End sets
##################################################

daemons.each do |daemon|
  namespace daemon do
    desc "#{daemon.capitalize}::Start"
    task :start, :roles => [:app] do
      run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/#{daemon}_daemon start"
    end

    desc "#{daemon.capitalize}::Stop"
    task :stop, :roles => [:app] do
      run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/#{daemon}_daemon stop"
    end

    desc "#{daemon.capitalize}::Restart"
    task :restart, :roles => [:app] do
      mailman.stop
      mailman.start
    end

    desc "#{daemon.capitalize}::Status"
    task :status, :roles => [:app] do
      run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/#{daemon}_daemon status"
    end
  end
end
