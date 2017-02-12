module Graph
  module Mutations
    FilmRate = GraphQL::Relay::Mutation.define do
      name "FilmRate"

      input_field :filmId, !types.ID
      input_field :rating, !types.Int

      return_field :film, Graph::Types::Film

      resolve ->(_, input, ctx) do
        # TODO auth error
        return unless user = ctx[:user]

        # TODO user error
        return unless film = Film.find_by(id: input["filmId"])

        rating = user.ratings.build(
          film: film,
          rating: input["rating"]
        )

        if rating.save
          {
            film: film
          }
        else
          # TODO add user errors
          {
            film: film
          }
        end
      end
    end
  end
end
