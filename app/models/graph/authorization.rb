module Graph
  module Authorization
    def self.init
      GraphQL::Relay::Mutation.accepts_definitions(login_required: LoginRequired)
      GraphQL::Schema.accepts_definitions(authorization: Authorization)
    end

    module Authorization
      extend self

      def call(schema, access_check_proc)
        schema.instrument(:field, Graph::Authorization::FieldInstrumenter.new(access_check_proc))
      end
    end

    module LoginRequired
      extend self

      def call(defn)
        defn.metadata[:login_required] = true
      end
    end

    class FieldInstrumenter
      def initialize(access_check_proc)
        @access_check_proc = access_check_proc
      end

      def instrument(type, field)
        if field.mutation && field.mutation.metadata[:login_required]
          new_resolver = check_login(type, field, field.resolve_proc)
          field.redefine do
            resolve new_resolver
          end
        else
          field
        end
      end

      private

      def check_login(type, field, resolve_proc)
        -> (obj, args, ctx) {
          has_access = @access_check_proc.call(ctx)

          raise GraphQL::ExecutionError.new("Authentication required to use: #{type.name}.#{field.name}") unless has_access

          resolve_proc.call(obj, args, ctx)
        }
      end
    end
  end
end
