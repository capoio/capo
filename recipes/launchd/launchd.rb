##################################################
###### Begin sets

set :launch_agents, {name: '~/Library/LaunchAgents/com.identifier.name.plist'}

###### End sets
##################################################

launch_agents.each_pair do |agent, path|
  namespace agent do
    desc "Start #{agent}"
    task :start do
      run "launchctl load -w #{path}"
    end

    desc "Stop #{agent}"
    task :stop do
      run "launchctl unload -w #{path}"
    end

    desc "Restart #{agent}"
    task :restart do
      send(agent).stop
      send(agent).start
    end
  end
end
