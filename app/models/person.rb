class Person < ApplicationRecord
  belongs_to :homeworld, class_name: 'Planet'

  has_and_belongs_to_many :starships
end
