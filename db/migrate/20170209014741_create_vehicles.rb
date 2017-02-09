class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :model
      t.string :vehicle_class
      t.string :manufacturer
      t.float :cost_in_credits
      t.float :length
      t.string :crew
      t.string :passengers
      t.integer :max_atmosphering_speed
      t.float :cargo_capacity
      t.string :consumables

      t.timestamps
    end
  end
end
