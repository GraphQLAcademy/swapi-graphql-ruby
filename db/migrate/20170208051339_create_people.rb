class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :birth_year
      t.string :eye_color
      t.string :gender
      t.string :hair_color
      t.integer :height
      t.integer :mass
      t.string :skin_color
      t.references :homeworld, foreign_key: { to_table: :planets }

      t.timestamps
    end
  end
end
