module Graph
  module Mutations
    FilmRate = GraphQL::Relay::Mutation.define do
      name "FilmRate"

      input_field :filmId, !types.ID
      input_field :rating, !types.Int

      return_field :film, !Graph::Types::Film
      return_field :rating, Graph::Types::Rating
      return_field :errors, !types[!Graph::Types::MutationError]

      login_required

      resolve ->(_, input, ctx) do
        film_id = Graph.parse_id(input['filmId'], Film)
        film = Film.find_by(id: film_id) if film_id
        raise GraphQL::ExecutionError.new('Invalid filmId.') unless film

        rating = ctx[:user].ratings.where(film: film).first_or_initialize
        rating.rating = input['rating']

        if rating.save
          {
            film: film,
            rating: rating,
            errors: []
          }
        else
          {
            film: film,
            rating: nil,
            errors: rating.errors.map { |field, message| MutationError.new(field, message) },
          }
        end
      end
    end
  end
end
