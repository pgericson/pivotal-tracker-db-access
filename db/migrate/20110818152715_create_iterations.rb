class CreateIterations < ActiveRecord::Migration
  def change
    create_table :iterations do |t|
      t.integer :pt_id
      t.integer :number
      t.datetime :start
      t.datetime :finish
      t.float :team_strength
      

      t.timestamps
    end
  end
end
