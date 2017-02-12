class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :ratings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :film, index: true
      t.integer :rating
      t.timestamps
    end
  end
end
