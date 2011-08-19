class Iteration < ActiveRecord::Base
  has_one :project,
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_iteration_id"

  def self.update(project)
    all_iterations = PivotalTracker::Iteration.all(project.pt)
    all_iterations.each do |iteration|
      i = self.find_or_create_by_pt_id_and_pt_project_id(iteration.id,project.pt_id)

      i.update_attributes_custom(iteration, :pt_project_id => project.pt_id)
      iteration.stories.each do |story|
        s = Story.find_or_create_by_pt_id(story.id)
        s.update_attributes_custom(story, :pt_iteration_id => iteration.id)
      end
    end
    all_iteration_stories = all_iterations.map{|i| i.stories}.flatten
    project.reload
    if all_iteration_stories.present?
      project.stories.where("stories.pt_id NOT IN (#{all_iteration_stories.map(&:id).join(",")})").update_all(:pt_iteration_id => nil)
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

  def get_pt_value(column, iteration)
    instance_variable = column.gsub(/^pt_(.*id)$/,'\1')
    if iteration.respond_to?(instance_variable)
      {column => iteration.send(instance_variable)}
    else
      {column => nil}
    end
  end
end
