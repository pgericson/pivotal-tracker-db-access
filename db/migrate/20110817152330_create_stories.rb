class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :pt_id
      t.integer :pt_project_id
      t.string :story_type
      t.string :url
      t.integer :estimate
      t.string :current_state
      t.text :description
      t.string :name
      t.string :requested_by
      t.string :owned_by
      t.datetime :pt_created_at
      t.datetime :accepted_at
      t.string :labels


      t.timestamps
    end
  end
end
