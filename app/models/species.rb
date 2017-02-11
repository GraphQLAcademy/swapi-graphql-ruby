class Species < ApplicationRecord
  belongs_to :homeworld, class_name: 'Planet'
  has_many :people
  has_and_belongs_to_many :films
end
