namespace :pt do
  desc "update everything project"
  task :update => :environment do
    puts "Starting Pivotal Tracker Data update"
    Project.update
    puts "#{Project.count.to_s} projects was found"
    Project.all.each do |project|
      puts "############################################"
      puts "## Starting to update stories for: " + project.name.to_s
      story_start = project.stories.last_updated.try(:updated_at)
      puts "Last story updated at: " + story_start.to_s
      Story.update(project)
      project.reload
      count = if story_start
        project.stories.where("updated_at > '#{story_start.to_s}'").count.to_s
      else
        project.stories.count.to_s
      end
      puts count + " stories was updated"

      story_start = project.stories.last_updated.try(:updated_at)

      puts "Starting updating Iterations and stories' iteration number"
      Iteration.update(project)
      project.reload
      count = if story_start
        project.stories.where("updated_at > '#{story_start.to_s}'").count.to_s
      else
        project.stories.count.to_s
      end
      puts count + " stories was updated"
    end

    puts "#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#"
    puts "ALL DONE"
    puts "#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#"
  end

end
