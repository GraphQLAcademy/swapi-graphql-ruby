class Planet < ApplicationRecord
  has_many :residents, class_name: 'Person', foreign_key: 'homeworld_id'
end
