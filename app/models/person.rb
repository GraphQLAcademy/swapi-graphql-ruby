class Person < ApplicationRecord
  belongs_to :homeworld, class_name: 'Planet'
  belongs_to :species

  has_and_belongs_to_many :starships
  has_and_belongs_to_many :vehicles
  has_and_belongs_to_many :films
end
