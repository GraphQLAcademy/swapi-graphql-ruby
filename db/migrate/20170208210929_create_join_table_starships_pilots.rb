class CreateJoinTableStarshipsPilots < ActiveRecord::Migration[5.0]
  def change
    create_join_table :starships, :people do |t|
      t.index :starship_id
      t.index :person_id
    end
  end
end
