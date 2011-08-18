class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :pt_id
      t.string :name
      t.integer :iteration_length
      t.string :week_start_day
      t.string :point_scale
      t.string :velocity_scheme
      t.integer :current_velocity
      t.integer :initial_velocity
      t.integer :number_of_done_iterations_to_show
      t.string :labels
      t.boolean :allow_attachments
      t.boolean :public
      t.boolean :use_https
      t.boolean :bugs_and_chores_are_estimatable
      t.boolean :commit_mode
      t.datetime :last_activity_at


      t.timestamps
    end
  end
end
