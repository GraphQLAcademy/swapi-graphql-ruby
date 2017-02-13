module Graph
  module Types
    MutationError = GraphQL::ObjectType.define do
      name "MutationError"

      field :field, !types.String, "The name of the input field that caused the error."
      field :message, !types.String, "The description of the error."
    end
  end
end
