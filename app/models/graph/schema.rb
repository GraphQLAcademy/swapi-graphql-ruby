module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query
    resolve_type ->(obj, ctx) do
      MySchema.types.values.find { |type| type.name == obj.class.name }
    end
  end
end
