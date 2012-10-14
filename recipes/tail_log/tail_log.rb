##################################################
###### Begin sets

###### End sets
##################################################

desc 'Tail application log'
task :tail_log, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env}.log"
end
