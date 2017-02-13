require "base64"

GraphiQL::Rails.config.initial_query = "query { allFilms { edges { node { title } } } }"

GraphiQL::Rails.config.headers['Authorization'] = -> (context) do
  credentials = Base64.strict_encode64("#{context.params['username']}:#{context.params['password']}")
  "basic #{credentials}"
end

GraphiQL::Rails.config.query_params = true
