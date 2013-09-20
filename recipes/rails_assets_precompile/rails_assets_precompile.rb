##################################################
###### Begin sets

###### End sets
##################################################

load 'deploy/assets'

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => {:no_release => true} do
      changed = if previous_release.nil?
        precompile_assets
      else
        old_rev = capture("cd #{previous_release} && git log --pretty=format:'%H' -n 1 | cat").strip
        new_rev = capture("cd #{latest_release} && git log --pretty=format:'%H' -n 1 | cat").strip
        assets_changed = capture("cd #{latest_release} && git diff #{old_rev} #{new_rev} --name-only | cat").include?('asset')
        gemfile_changed = capture("cd #{latest_release} && git diff #{old_rev} #{new_rev} --name-only | cat").include?('Gemfile.lock')
        if assets_changed || (gemfile_changed && Capistrano::CLI.ui.ask("Gemfile changed. Enter 'yes' to precomple assets?") == 'yes')
          precompile_assets
        else
          logger.info 'Skipping asset precompilation because there were no asset changes.'
        end
      end
    end
  end
end

def precompile_assets
  run <<-CMD.compact
    cd -- #{latest_release} &&
    RAILS_ENV=#{rails_env.to_s.shellescape} #{asset_env} #{rake} assets:precompile
  CMD

  if capture("ls -1 #{shared_path.shellescape}/#{shared_assets_prefix}/manifest* | wc -l").to_i > 1
    raise "More than one asset manifest file was found in '#{shared_path.shellescape}/#{shared_assets_prefix}'.  If you are upgrading a Rails 3 application to Rails 4, follow these instructions: http://github.com/capistrano/capistrano/wiki/Upgrading-to-Rails-4#asset-pipeline"
  end

  # Sync manifest filenames across servers if our manifest has a random filename
  if shared_manifest_path =~ /manifest-.+\./
    run <<-CMD.compact
      [ -e #{shared_manifest_path.shellescape} ] || mv -- #{shared_path.shellescape}/#{shared_assets_prefix}/manifest* #{shared_manifest_path.shellescape}
    CMD
  end

  # Copy manifest to release root (for clean_expired task)
  run <<-CMD.compact
    cp -- #{shared_manifest_path.shellescape} #{current_release.to_s.shellescape}/assets_manifest#{File.extname(shared_manifest_path)}
  CMD
end
