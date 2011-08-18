class Project < ActiveRecord::Base
  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"

  has_many :iterations, 
           :primary_key => "pt_id",
           :foreign_key => "pt_project_id"
end
