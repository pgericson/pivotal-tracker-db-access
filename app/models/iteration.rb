class Iteration < ActiveRecord::Base
  belongs_to :project,
             :primary_key => "pt_project_id",
             :foreign_key => "pt_id"

  has_many :stories, 
           :primary_key => "pt_id",
           :foreign_key => "pt_iteration_id"

end
