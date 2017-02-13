class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :film

  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
