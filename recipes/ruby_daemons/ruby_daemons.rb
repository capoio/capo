##################################################
###### Begin sets

unless exists?(:daemons)
  set :daemons, [:dameon_name]
end

###### End sets
##################################################

daemons.each do |daemon|
  namespace daemon do
    %w[start stop status].each do |command|
      desc "#{daemon.capitalize}::#{command.capitalize}"
      task command, :roles => [:app] do
        run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/#{daemon}_daemon #{command}"
      end
    end

    desc "#{daemon.capitalize}::Restart"
    task :restart, :roles => [:app] do
      send(daemon).stop
      send(daemon).start
    end
  end
end
