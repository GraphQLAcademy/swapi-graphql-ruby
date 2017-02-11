module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query
  end
end
