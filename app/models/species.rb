class Species < ApplicationRecord
  belongs_to :homeworld, class_name: 'Planet'
  has_many :people
end
