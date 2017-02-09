class Starship < ApplicationRecord
  has_and_belongs_to_many :pilots,
    class_name: 'Person',
    join_table: 'people_starships',
    foreign_key: 'starship_id',
    association_foreign_key: 'person_id'
end
