module Graph
  module Types
    Query = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      # Relay
      field :node, GraphQL::Relay::Node.field
      field :nodes, GraphQL::Relay::Node.plural_field

      field :person, Graph.find_by_id_field(Graph::Types::Person, ::Person)
      field :people, types[Graph::Types::Person] do
        resolve ->(_, _, _) { ::Person.all }
      end

      field :planet, Graph.find_by_id_field(Graph::Types::Planet, ::Planet)
      field :planets, types[Graph::Types::Planet] do
        resolve ->(_, _, _) { ::Planet.all }
      end

      field :film, Graph.find_by_id_field(Graph::Types::Film, ::Film)
      field :films, types[Graph::Types::Film] do
        resolve ->(_, _, _) { ::Film.all }
      end

      field :species, Graph.find_by_id_field(Graph::Types::Species, ::Species)
      field :allSpecies, types[Graph::Types::Species] do
        resolve ->(_, _, _) { ::Species.all }
      end

      field :starship, Graph.find_by_id_field(Graph::Types::Starship, ::Starship)
      field :starships, types[Graph::Types::Starship] do
        resolve ->(_, _, _) { ::Starship.all }
      end

      field :vehicle, Graph.find_by_id_field(Graph::Types::Vehicle, ::Vehicle)
      field :vehicles, types[Graph::Types::Vehicle] do
        resolve ->(_, _, _) { ::Vehicle.all }
      end
    end
  end
end
