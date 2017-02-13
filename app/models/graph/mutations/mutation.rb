module Graph
  module Mutations
    Mutation = GraphQL::ObjectType.define do
      name "Mutation"
      field :filmRate, field: Graph::Mutations::FilmRate.field
    end
  end
end
