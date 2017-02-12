module Graph
  module Types
    TransportInterface = GraphQL::InterfaceType.define do
      name "Transport"
      description "A single transport craft"

      field :name, !types.String
      field :model, types.String
      field :manufacturer, types.String
      field :costInCredits, types.Float
      field :length, types.Float
      field :crew, types.String
      field :passengers, types.String
      field :maxAtmospheringSpeed, types.Int
      field :cargoCapacity, types.Float
      field :consumables, types.String
      connection :pilots, Graph::Types::Person.connection_type
    end
  end
end
