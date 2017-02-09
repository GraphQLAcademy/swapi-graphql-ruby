class CreateJoinTableVehiclesPeople < ActiveRecord::Migration[5.0]
  def change
    create_join_table :vehicles, :people do |t|
      t.index :vehicle_id
      t.index :person_id
    end
  end
end
