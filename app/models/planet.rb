class Planet < ApplicationRecord
  has_many :residents, class_name: 'Person', foreign_key: 'homeworld_id'
  has_and_belongs_to_many :films
end
