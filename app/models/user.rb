class User < ApplicationRecord
  has_secure_password
  has_many :ratings
  has_many :rated_films, through: :ratings, source: :film
end
