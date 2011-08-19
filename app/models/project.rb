class Project < ActiveRecord::Base
  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"

  has_many :iterations, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"


  def self.update
    all_projects = PivotalTracker::Project.all
    all_projects.each do |project|
      p = self.find_or_create_by_pt_id(project.id)
      p.update_attributes_custom(project)
    end
  end

  def self.update_everything
    Project.update
    Project.all.each do |project|
      Story.update(project)
      Iteration.update(project)
    end
  end

  def pt
    PivotalTracker::Project.find(pt_id)
  end

  def update_attributes_custom(project, params = {})
    columns = self.class.column_names - %w(created_at updated_at id)
    result = {}
    columns.each do |column|
      result.merge!(get_pt_value(column, project))
    end
    update_attributes(result.merge(params))
  end

  def get_pt_value(column, project)
    instance_variable = column.gsub(/^pt_(.*id)$/,'\1')
    if project.respond_to?(instance_variable)
      {column => project.send(instance_variable)}
    else
      {column => nil}
    end
  end
end
