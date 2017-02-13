class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :film

  validates_inclusion_of :rating, in: 0..5
end
