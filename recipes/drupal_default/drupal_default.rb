# List the Drupal multi-site folders.  Use "default" if no multi-sites are installed.
set :domains, ["default"]

# Set the deployment directory on the target hosts.
set :deploy_to, "/var/www/#{application}"

# The hostnames to deploy to.
role :web, "devel.example.com"

# Specify one of the web servers to use for database backups or updates.
# This server should also be running Drupal.
role :db, "devel.example.com", :primary => true

# The username on the target system, if different from your local username
# ssh_options[:user] = 'alice'

# The path to drush
set :drush, "cd #{current_path} ; /usr/bin/php /data/lib/php/drush/drush.php"


namespace :deploy do

  # Overwritten to provide flexibility for people who aren't using Rails.
  desc "Prepares one or more servers for deployment."
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, releases_path, shared_path]
    domains.each do |domain|
      dirs += [shared_path + "/#{domain}/files"]
    end
    dirs += %w(system).map { |d| File.join(shared_path, d) }
    run "umask 02 && mkdir -p #{dirs.join(' ')}"
  end

  desc "Create settings.php in shared/config"
  task :after_setup do
    configuration = <<-EOF
<?php
$db_url = 'mysql://username:password@localhost/databasename';
$db_prefix = '';
EOF
    domains.each do |domain|
      put configuration, "#{deploy_to}/#{shared_dir}/#{domain}/local_settings.php"
    end
  end

  desc "link file dirs"
  task :after_update_code do
    domains.each do |domain|
    # link settings file
      run "ln -nfs #{deploy_to}/#{shared_dir}/#{domain}/local_settings.php #{release_path}/sites/#{domain}/local_settings.php"
      # remove any link or directory that was exported from SCM, and link to remote Drupal filesystem
      run "rm -rf #{release_path}/sites/#{domain}/files"
      run "ln -nfs #{deploy_to}/#{shared_dir}/#{domain}/files #{release_path}/sites/#{domain}/files"
    end
  end

  # desc '[internal] Touches up the released code.'
  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{release_path}"
  end

  desc "Flush the Drupal cache system."
  task :cacheclear, :roles => :db, :only => { :primary => true } do
    domains.each do |domain|
      run "#{drush} --uri=#{domain} cache clear"
    end
  end

  namespace :web do
    desc "Set Drupal maintainance mode to online."
    task :enable do
      domains.each do |domain|
        php = 'variable_set("site_offline", FALSE)'
        run "#{drush} --uri=#{domain} eval '#{php}'"
      end
    end

    desc "Set Drupal maintainance mode to off-line."
    task :disable do
      domains.each do |domain|
        php = 'variable_set("site_offline", TRUE)'
        run "#{drush} --uri=#{domain} eval '#{php}'"
      end
    end
  end

  after "deploy", "deploy:cacheclear"
  after "deploy", "deploy:cleanup"


  # Each of the following tasks are Rails specific. They're removed.
  task :migrate do
  end

  task :migrations do
  end

  task :cold do
  end

  task :start do
  end

  task :stop do
  end

  task :restart do
  end

end
