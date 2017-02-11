module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query
    resolve_type ->(obj, ctx) do
      Graph::Schema.types.values.find { |type| type.name == obj.class.name }
    end
  end
end
