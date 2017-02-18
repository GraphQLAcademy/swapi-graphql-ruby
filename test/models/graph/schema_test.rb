require 'test_helper'

class Graph::SchemaTest < ActiveSupport::TestCase
  test "Ensure IDL is updated when changes are made to the schema" do
    old_idl = File.read(Rails.root.join('db/schema.graphql'))
    new_idl = Graph::Schema.to_definition

    assert new_idl == old_idl,
      "The GraphQL schema was updated but the IDL at `db/schema.graphql` was not updated.\n" \
      "Run `rake graphql:schema:dump` to update `db/schema.graphql`."
  end
end
