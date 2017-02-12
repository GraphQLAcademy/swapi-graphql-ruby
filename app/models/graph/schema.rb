module Graph
  Schema = GraphQL::Schema.define do
    query Graph::Types::Query

    resolve_type ->(obj, ctx) do
      Graph::Schema.types.values.find { |type| type.name == obj.class.name }
    end

    id_from_object ->(object, type_definition, query_ctx) do
      URI::GID.build(app: GlobalID.app, model_name: type_definition.name, model_id: object.id)
    end

    object_from_id ->(id, query_ctx) do
      gid = GlobalID.parse(id)
      possible_types = query_ctx.warden.possible_types(GraphQL::Relay::Node.interface)

      return unless possible_types.map(&:name).include?(gid.model_name)
      return unless gid.app == GlobalID.app

      Object.const_get(gid.model_name).find(gid.model_id)
    end

    lazy_resolve(Promise, :sync)
    instrument(:query, GraphQL::Batch::Setup)
  end
end
