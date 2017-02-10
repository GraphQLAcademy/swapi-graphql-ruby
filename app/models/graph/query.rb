module Graph
  Query = GraphQL::ObjectType.define do
    name "Query"
    description "The query root of this schema"

    # TODO(xuorig) Populate with real fields (GraphiQL crashes with no fields on root)
    field :test, types.String, resolve: ->(_, _, _) { 'test' }
  end
end
