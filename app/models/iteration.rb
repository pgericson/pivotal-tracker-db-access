class Iteration < ActiveRecord::Base
  belongs_to :project,
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_iteration_id"

  def self.update(project)
    all_iterations = PivotalTracker::Iteration.all(PivotalTracker::Project.find(project.pt_id))
    all_iterations.each do |iteration|
      i = self.find_or_create_by_pt_id_and_pt_project_id(iteration.id,project.pt_id)
      i.update_attributes_custom(iteration)
      Project.find(project.id).stories.update_all(:pt_iteration_id => nil)
      iteration.stories.each do |story|
        s = Story.find_or_create_by_pt_id(story.id)
        s.update_attributes_custom(story, :pt_iteration_id => iteration.id)
      end
    end
  end

  def update_attributes_custom(iteration, params = {})
    columns = self.class.column_names - %w(created_at updated_at id)
    result = {}
    columns.each do |column|
      result.merge!(get_pt_value(column, iteration))
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
