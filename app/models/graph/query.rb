module Graph
  Query = GraphQL::ObjectType.define do
    name "Query"
    description "The query root of this schema"

    field :person, Graph::Types::Person do
      argument :id, types.ID
      resolve ->(_, args, _) { Person.find(args['id']) }
    end

    field :people, types[Graph::Types::Person] do
      resolve ->(_, _, _) { Person.all }
    end
  end
end
