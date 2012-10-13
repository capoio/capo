configs do
  description 'Default Rails environment configs actions, this will create a shared config folder and symlinks files after deploy'
  version 0.1
  tags %w[rails config shared symlinks]
  category 'rails'
  dependencies %w[]
end

unless exists?(:configs)
  set :configs, [:database]
end

namespace :configs do
  namespace name do
    desc "Create #{name}.yml in shared/config"
    task :copy do
      run "mkdir -p #{shared_path}/config"

      CONFIG = YAML.load_file(%Q{./config/#{name}.yml})[rails_env.to_s]
      put CONFIG.map{|key, value| "#{key}: #{value}\n"}.join, "#{shared_path}/config/#{name}.yml"
    end

    desc "Link the #{name}.yml"
    task :link do
      run "ln -nfs #{shared_path}/config/#{name}.yml #{release_path}/config/#{name}.yml"
    end
  end

  after 'deploy:setup', "configs:#{name}:copy"
  after 'deploy:finalize_update', "configs:#{name}:link"
end
