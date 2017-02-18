namespace :graphql do
  namespace :schema do
    task dump: :environment do
      idl = Graph::Schema.to_definition
      path = Rails.root.join('db/schema.graphql')

      # TODO - Once https://github.com/rmosolgo/graphql-ruby/pull/384 is merged we can
      #        verify if any breaking changes were made. If so, the rake task will early
      #        exit unless `FORCE=1` is specified.

      File.open(path, 'w') { |file| file.write(idl) }

      puts "Wrote IDL to '#{path}'\n"
    end
  end
end
