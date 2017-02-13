module Graph
  module Types
    Query = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :person, Graph.find_by_id_field(Graph::Types::Person, ::Person)
      connection :allPeople, Person.connection_type do
        resolve ->(_, _, _) {
          ::Person.all
        }
      end

      field :planet, Graph.find_by_id_field(Graph::Types::Planet, ::Planet)
      connection :allPlanets, Planet.connection_type do
        resolve ->(_, _, _) {
          ::Planet.all
        }
      end

      field :film, Graph.find_by_id_field(Graph::Types::Film, ::Film)
      connection :allFilms, Film.connection_type do
        resolve ->(_, _, _) {
          ::Film.all
        }
      end

      field :species, Graph.find_by_id_field(Graph::Types::Species, ::Species)
      connection :allSpecies, Species.connection_type do
        resolve ->(_, _, _) {
          ::Species.all
        }
      end

      field :starship, Graph.find_by_id_field(Graph::Types::Starship, ::Starship)
      connection :allStarships, Starship.connection_type do
        resolve ->(_, _, _) {
          ::Starship.all
        }
      end

      field :vehicle, Graph.find_by_id_field(Graph::Types::Vehicle, ::Vehicle)
      connection :allVehicles, Vehicle.connection_type do
        resolve ->(_, _, _) {
          ::Vehicle.all
        }
      end

      field :viewer, Graph::Types::User, 'The currently authenticated user (if any)' do
        resolve ->(_, _, ctx) {
          ctx[:user]
        }
      end

      # Relay
      field :node, GraphQL::Relay::Node.field
      field :nodes, GraphQL::Relay::Node.plural_field
    end
  end
end
