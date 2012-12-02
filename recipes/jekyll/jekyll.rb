##################################################
###### Begin sets

###### End sets
##################################################

before 'deploy:update', 'deploy:update_jekyll'

namespace :deploy do

  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :update_jekyll do
    %x(rm -rf _site/* && jekyll)
  end

end
