##################################################
###### Begin sets

###### End sets
##################################################

load 'deploy/assets'

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => {:no_release => true} do
      changed = if previous_release.nil?
        # Propably first deploy, so precompile them anyway.
        run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile"
      else
        old_rev = capture("cd #{previous_release} && git log --pretty=format:'%H' -n 1 | cat").strip
        new_rev = capture("cd #{latest_release} && git log --pretty=format:'%H' -n 1 | cat").strip
        assets_changed = capture("cd #{latest_release} && git diff #{old_rev} #{new_rev} --name-only | cat").include?('asset')
        gemfile_changed = capture("cd #{latest_release} && git diff #{old_rev} #{new_rev} --name-only | cat").include?('Gemfile.lock')
        if assets_changed || (gemfile_changed && Capistrano::CLI.ui.ask("Gemfile changed. Enter 'yes' to precomple assets?") == 'yes')
          run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile"
        else
          logger.info 'Skipping asset precompilation because there were no asset changes.'
        end
      end
    end
  end
end
