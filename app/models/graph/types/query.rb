module Graph
  module Types
    Query = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :person, Graph::Types::Person do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Person.find_by(id: args['id']) }
      end

      field :people, types[Graph::Types::Person] do
        resolve ->(_, _, _) { ::Person.all }
      end

      field :planet, Graph::Types::Planet do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Planet.find(args['id']) }
      end

      field :planets, types[Graph::Types::Planet] do
        resolve ->(_, _, _) { ::Planet.all }
      end

      field :film, Graph::Types::Film do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Film.find(args['id']) }
      end

      field :films, types[Graph::Types::Film] do
        resolve ->(_, _, _) { ::Film.all }
      end

      field :species, Graph::Types::Species do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Species.find(args['id']) }
      end

      field :allSpecies, types[Graph::Types::Species] do
        resolve ->(_, _, _) { ::Species.all }
      end

      field :starship, Graph::Types::Starship do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Starship.find(args['id']) }
      end

      field :starships, types[Graph::Types::Starship] do
        resolve ->(_, _, _) { ::Starship.all }
      end

      field :vehicle, Graph::Types::Vehicle do
        argument :id, types.ID
        resolve ->(_, args, _) { ::Vehicle.find(args['id']) }
      end

      field :vehicles, types[Graph::Types::Vehicle] do
        resolve ->(_, _, _) { ::Vehicle.all }
      end
    end
  end
end
