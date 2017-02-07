class CreatePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets do |t|
      t.string :name
      t.integer :diameter
      t.integer :rotation_period
      t.integer :orbital_period
      t.string :gravity
      t.integer :population, limit: 5 # bigint
      t.string :climate
      t.string :terrain
      t.float :surface_water

      t.timestamps
    end
  end
end
