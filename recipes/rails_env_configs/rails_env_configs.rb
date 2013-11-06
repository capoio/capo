##################################################
###### Begin sets

_cset :configs, [:database]

###### End sets
##################################################

namespace :configs do
  configs.each do |name|
    namespace name do
      desc "Create #{name}.yml in shared/config"
      task :copy do
        run "mkdir -p #{shared_path}/config"

        config = YAML.load_file(%Q{./config/#{name}.yml})[rails_env.to_s]
        put({rails_env => config}.to_yaml, "#{shared_path}/config/#{name}.yml")
      end

      desc "Link the #{name}.yml"
      task :link do
        run "ln -nfs #{shared_path}/config/#{name}.yml #{release_path}/config/#{name}.yml"
      end
    end

    after 'deploy:setup', "configs:#{name}:copy"
    after 'deploy:finalize_update', "configs:#{name}:link"
  end
end
