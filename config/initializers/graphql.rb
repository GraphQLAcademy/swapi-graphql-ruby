# TODO(xuorig) remove this when
# https://github.com/rmosolgo/graphql-ruby/pull/535 is fixed
module GraphQL
  class BaseType
    def connection_type
      name # lolwat
      @connection_type ||= define_connection
    end
  end
end

GraphQL::ObjectType.accepts_definitions(
  model: GraphQL::Define.assign_metadata_key(:model)
)
