class FixPlanetPopulation < ActiveRecord::Migration[5.0]
  def change
    change_column :planets, :population, :float, limit: nil
  end
end
