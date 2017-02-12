class User < ApplicationRecord
  has_many :ratings
  has_many :films, through: :ratings
end
