module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query

    resolve_type ->(obj, ctx) do
      Graph::Schema.types.values.find { |type| type.name == obj.class.name }
    end

    id_from_object ->(object, type_definition, query_ctx) {
      URI::GID.build(app: GlobalID.app, model_name: type_definition.name, model_id: object.id)
    }

    object_from_id ->(id, query_ctx) {
      gid = GlobalID.parse(id)
      Object.const_get(gid.model_name).find(gid.model_id)
    }
  end
end
