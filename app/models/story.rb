class Story < ActiveRecord::Base
  has_one :project, 
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  has_one :iteration, 
             :primary_key => "pt_iteration_id",
             :foreign_key => "pt_id"

  def self.last_updated
    order("stories.updated_at DESC").first
  end

  def pt
    project.pt.stories.find(pt_id)
  end

  def self.pt
    PivotalTracker::Story
  end

  def self.update(project)
    all_stories = project.pt.stories.all
    all_stories.each_with_index do |story,i|
      s = self.find_or_create_by_pt_id(story.id)
      s.update_attributes_custom(story, :rank => i + 1)
    end
    project.reload
    delete_ids = project.stories.map{|s| s.pt_id} - all_stories.map{|s| s.id}
    if delete_ids.present?
      Story.destroy_all("stories.pt_id IN (#{delete_ids.join(",")})")
    end
  end

  def update_attributes_custom(story, params = {})
    columns = self.class.column_names - %w(created_at updated_at id pt_iteration_id rank)
    result = {}
    columns.each do |column|
      result.merge!(get_pt_value(column, story))
    end
    update_attributes(result.merge(params))
  end

  def get_pt_value(column, story)
    instance_variable = column.gsub(/^pt_(.*id)$/,'\1')
    if story.respond_to?(instance_variable)
      value = if column == "labels" && v = story.send(instance_variable)
        v.split(",").sort{|a,b| a <=> b}.join(",")
      else
        story.send(instance_variable)
      end
      {column => value}
    else
      {column => nil}
    end
  end
end
