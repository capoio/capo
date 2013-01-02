##################################################
###### Begin sets

###### End sets
##################################################

after 'deploy:update', 'deploy:update_jekyll'

namespace :deploy do

  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :update_jekyll do
    # This will just generate the statis files, this will NOT start a jekyll server.
    # The utf-8 is to make sure you can use special characters in your files.
    run "cd #{latest_release} && LC_ALL='en_US.UTF-8' jekyll --no-auto"
  end

end
