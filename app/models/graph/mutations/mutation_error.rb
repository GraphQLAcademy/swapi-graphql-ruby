module Graph
  module Mutations
    class MutationError < Struct.new(:field, :message)
    end
  end
end
