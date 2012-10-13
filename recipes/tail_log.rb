configs do
  description 'Tail the environment logs'
  version 0.1
  tags %w[defaults]
  category 'actions'
  dependencies %w[]
end

desc 'Tail application log'
task :tail_log, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env}.log"
end
