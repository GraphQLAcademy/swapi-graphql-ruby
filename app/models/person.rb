class Person < ApplicationRecord
  belongs_to :homeworld, class_name: 'Planet'
end
