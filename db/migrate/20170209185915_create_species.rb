class CreateSpecies < ActiveRecord::Migration[5.0]
  def change
    create_table :species do |t|
      t.string :name
      t.string :classification
      t.string :designation
      t.float :average_height
      t.integer :average_lifespan
      t.string :eye_colors
      t.string :hair_colors
      t.string :skin_colors
      t.string :language
      t.references :homeworld, foreign_key: true

      t.timestamps
    end
  end
end
