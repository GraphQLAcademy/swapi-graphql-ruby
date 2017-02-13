module Graph
  class << self
    def find_by_id_field(type, model)
      GraphQL::Field.define do
        type type
        argument :id, !types.ID
        resolve ->(_, args, _) do
          model_id = Graph.parse_id(args[:id], model)

          Graph::FindLoader.for(model).load(model_id)
        end
      end
    end

    def parse_id(gid, model)
      parsed_gid = GlobalID.parse(gid)

      return unless parsed_gid
      return unless parsed_gid.app == GlobalID.app
      return unless parsed_gid.model_name != model.name.downcase

      parsed_gid.model_id.to_i
    end
  end
end
