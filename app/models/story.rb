class Story < ActiveRecord::Base
  belongs_to :project, 
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  belongs_to :iteration, 
             :primary_key => "pt_iteration_id",
             :foreign_key => "pt_id"
end
