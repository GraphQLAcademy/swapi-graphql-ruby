module Graph
  module Types
    User = GraphQL::ObjectType.define do
      name "User"
      description "A user that can rate films."

      field :name, !types.String
      field :username, !types.String
      field :createdAt, !types.String, "The ISO 8601 date format of the time that this resource was created."
      field :updatedAt, !types.String, "The ISO 8601 date format of the time that this resource was updated."
    end
  end
end
