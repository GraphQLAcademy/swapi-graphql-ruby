module Graph
  module Types
    Rating = GraphQL::ObjectType.define do
      name "Rating"
      description "A rating made by a user on a film."

      interfaces [GraphQL::Relay::Node.interface]

      field :user, !Graph::Types::User, "The critic." do
        preloads :user
      end

      field :film, !Graph::Types::Film, "The rated film." do
        preloads :film
      end

      field :rating, !types.Int, "A film rating from 0 to 5."
      field :createdAt, !types.String,
        "The ISO 8601 date format of the time that this resource was created.", property: :created_at
      field :updatedAt, !types.String,
        "The ISO 8601 date format of the time that this resource was updated.", property: :updated_at
    end
  end
end
