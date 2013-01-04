##################################################
###### Begin sets

unless exists?(:daemons)
  set :daemons, [:dameon_name]
end

###### End sets
##################################################

daemons_per_role = daemons.is_a?(Array) ? {:app => daemons} : daemons

daemons_per_role.each do |role, daemons|
  daemons.each do |daemon|
    namespace daemon do
      %w[start stop status].each do |command|
        desc "#{daemon} #{command}"
        task command, :roles => [role] do
          run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/#{daemon}_daemon #{command}"
        end
      end

      desc "#{daemon} restart"
      task :restart, :roles => [role] do
        send(daemon).stop
        send(daemon).start
      end
    end
  end
end
