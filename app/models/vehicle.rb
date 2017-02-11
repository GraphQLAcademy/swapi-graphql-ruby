class Vehicle < ApplicationRecord
  has_and_belongs_to_many :pilots,
    class_name: 'Person',
    join_table: 'people_vehicles',
    foreign_key: 'vehicle_id',
    association_foreign_key: 'person_id'
  has_and_belongs_to_many :films
end
