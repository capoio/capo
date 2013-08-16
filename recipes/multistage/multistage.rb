##################################################
###### Begin sets

###### End sets
##################################################

location = fetch :stage_dir, 'config/deploy/stages'

unless exists?(:stages)
  set :stages, Dir["#{location}/*.rb"].map { |f| File.basename f, '.rb' }
end

stages.each do |name|
  desc "Set the target stage to `#{name}'."
  task name do
    set :stage, name.to_sym
    load "#{location}/#{stage}"
  end
end

namespace :multistage do
  desc "[internal] Ensure that a stage has been selected."
  task :ensure do
    unless exists?(:stage)
      if exists?(:default_stage)
        logger.important "Defaulting to `#{default_stage}'"
        find_and_execute_task default_stage
      else
        abort "No stage specified. Please specify one of: #{stages.join(', ')} (e.g. `cap #{stages.first} #{ARGV.last}')"
      end
    end
  end
end

on :start, 'multistage:ensure', :except => stages + ['multistage:prepare']
