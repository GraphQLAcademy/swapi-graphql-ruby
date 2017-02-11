module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query

    resolve_type ->(obj, ctx) do
      Graph::Schema.types.values.find { |type| type.metadata[:model] == obj.class }
    end

    id_from_object ->(object, type_definition, query_ctx) do
      URI::GID.build(app: GlobalID.app, model_name: type_definition.name, model_id: object.id)
    end

    object_from_id ->(id, query_ctx) do
      gid = GlobalID.parse(id)
      object_class = Object.const_get(gid.model_name)

      possible_types = query_ctx.warden.possible_types(GraphQL::Relay::Node.interface)
      possible_models = possible_types.map { |type| type.metadata[:model] }

      return unless object_class
      return unless possible_models.include?(object_class)
      return unless gid.app == GlobalID.app

      object_class.find(gid.model_id)
    end
  end
end
