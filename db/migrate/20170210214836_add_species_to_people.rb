class AddSpeciesToPeople < ActiveRecord::Migration[5.0]
  def change
    change_table :people do |t|
      t.references :species, foreign_key: true
    end
  end
end
