class Film < ApplicationRecord
  has_and_belongs_to_many :species
  has_and_belongs_to_many :starships
  has_and_belongs_to_many :vehicles
  has_and_belongs_to_many :planets
  has_and_belongs_to_many :characters,
    class_name: 'Person',
    join_table: 'films_people',
    foreign_key: 'film_id',
    association_foreign_key: 'person_id'

  has_many :ratings
  has_many :critics, through: :ratings, source: :user
end
