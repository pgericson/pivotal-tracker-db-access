class Project < ActiveRecord::Base
  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"

  has_many :iterations, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"


  def self.update_everything
    all_projects = PivotalTracker::Project.all
    all_projects.each do |project|
      p = self.find_or_create_by_pt_id(project.id)
      p.update_attributes_custom(project)
    end
  end

  def update_attributes_custom(project)
    columns = self.class.column_names - %w(created_at updated_at id)
    columns.inject({}) do |result, column|
      result.merge(make_hash(column, project))
      result
    end
  end

  def make_hash(column, project)
    instance_variable = column.gsub(/^pt_(.*id)$/,'\1')
    if project.respond_to?(instance_variable)
      {column => project.send(instance_variable)}
    else
      {}
    end
  end
end
