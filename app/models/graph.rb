module Graph
  class << self
    def find_by_id_field(type, model)
      GraphQL::Field.define do
        type type
        argument :id, !types.ID
        resolve ->(_, args, _) do
          gid = GlobalID.parse(args[:id])

          return unless gid
          return unless gid.model_name == type.name

          Graph::FindLoader.for(model).load(gid.model_id.to_i)
        end
      end
    end
  end
end
