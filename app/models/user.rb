class User < ApplicationRecord
  has_many :ratings
  has_many :rated_films, through: :ratings, source: :film
end
