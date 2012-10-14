##################################################
###### Begin sets

set :drush_cmd, 'drush_cmd'
set :app_path, 'app_path'

###### End sets
##################################################

namespace :drush do

  desc "Backup the database"
  task :backupdb, :on_error => :continue do
    run "#{drush_cmd} -r #{app_path} bam-backup"
  end

  desc "Run Drupal database migrations if required"
  task :updatedb, :on_error => :continue do
    run "#{drush_cmd} -r #{app_path} updatedb -y"
  end

  desc "Clear the drupal cache"
  task :cache_clear, :on_error => :continue do
    run "#{drush_cmd} -r #{app_path} cc all"
  end

  desc "Set the site offline"
  task :site_offline, :on_error => :continue do
    run "#{drush_cmd} -r #{app_path} vset site_offline 1 -y"
    run "#{drush_cmd} -r #{app_path} vset maintenance_mode 1 -y"
  end

  desc "Set the site online"
  task :site_online, :on_error => :continue do
    run "#{drush_cmd} -r #{app_path} vset site_offline 0 -y"
    run "#{drush_cmd} -r #{app_path} vset maintenance_mode 0 -y"
  end

end
