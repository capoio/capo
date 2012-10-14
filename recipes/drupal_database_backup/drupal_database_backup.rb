##################################################
###### Begin sets

###### End sets
##################################################

desc "Download a backup of the database(s) from the given stage."
task :download_db, :roles => :db, :only => { :primary => true } do
  domains.each do |domain|
    filename = "#{domain}_#{stage}.sql"
    run "#{drush} --uri=#{domain} sql dump --structure-tables-key=common > ~/#{filename}"
    download("~/#{filename}", "db/#{filename}", :via=> :scp)
  end
end
