class Story < ActiveRecord::Base
  belongs_to :project, 
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  belongs_to :iteration, 
             :primary_key => "pt_iteration_id",
             :foreign_key => "pt_id"

  def self.update(project)
    all_stories = PivotalTracker::Story.all(PivotalTracker::Project.find(project.pt_id))
    all_stories.each_with_index do |story,i|
      s = self.find_or_create_by_pt_id(story.id)
      s.update_attributes_custom(story, :rank => i + 1)
    end
    delete_ids = Project.find(project.id).stories.map{|s| s.pt_id} - all_stories.map{|s| s.id}
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

  def get_pt_value(column, project)
    instance_variable = column.gsub(/^pt_(.*id)$/,'\1')
    if project.respond_to?(instance_variable)
      {column => project.send(instance_variable)}
    else
      {}
    end
  end
end
