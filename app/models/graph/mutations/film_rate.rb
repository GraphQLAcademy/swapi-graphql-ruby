module Graph
  module Mutations
    FilmRate = GraphQL::Relay::Mutation.define do
      name "FilmRate"

      input_field :filmId, !types.ID
      input_field :rating, !types.Int

      return_field :film, Graph::Types::Film
      return_field :errors, !types[!Graph::Types::MutationError]

      resolve ->(_, input, ctx) do
        raise GraphQL::ExecutionError.new('Authentication required to rate a film.') unless user = ctx[:user]

        film_id = Graph.parse_id(input['filmId'], Film)
        film = Film.find_by(id: film_id) if film_id
        raise GraphQL::ExecutionError.new('Invalid filmId.') unless film

        rating = user.ratings.where(film: film).first_or_initialize
        rating.rating = input['rating']

        if rating.save
          {
            film: film,
            errors: []
          }
        else
          {
            film: film,
            errors: rating.errors.map { |field, message| MutationError.new(field, message) },
          }
        end
      end
    end
  end
end
