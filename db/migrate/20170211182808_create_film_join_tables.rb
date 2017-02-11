class CreateFilmJoinTables < ActiveRecord::Migration[5.0]
  def change
    create_join_table :films, :species do |t|
      t.index :film_id
      t.index :species_id
    end

    create_join_table :films, :starships do |t|
      t.index :film_id
      t.index :starship_id
    end

    create_join_table :films, :vehicles do |t|
      t.index :film_id
      t.index :vehicle_id
    end

    create_join_table :films, :people do |t|
      t.index :film_id
      t.index :person_id
    end

    create_join_table :films, :planets do |t|
      t.index :film_id
      t.index :planet_id
    end
  end
end
