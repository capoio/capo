##################################################
###### Begin sets

###### End sets
##################################################

desc 'Prompts if new migrations are available and runs them if you want to'
namespace :deploy do
  task :needs_migrations, :roles => :db, :only => {:primary => true} do
    migrations_changed = if previous_release.nil?
      true # propably first deploy, so no migrations to compare
    else
      old_rev = capture("cd #{previous_release} && git log --pretty=format:'%H' -n 1 | cat").strip
      new_rev = capture("cd #{latest_release} && git log --pretty=format:'%H' -n 1 | cat").strip
      capture("cd #{latest_release} && git diff #{old_rev} #{new_rev} --name-only | cat").include?('db/migrate')
    end
    if migrations_changed && Capistrano::CLI.ui.ask("New migrations pending. Enter 'yes' to run db:migrate") == 'yes'
      migrate
    end
  end
end
after 'deploy:update_code', 'deploy:needs_migrations'
