module Graph
  module Types
    Film = GraphQL::ObjectType.define do
      name "Film"
      description "A single film."

      interfaces [GraphQL::Relay::Node.interface]

      global_id_field :id

      field :title, types.String, "The title of this film"
      field :episodeID, types.Int, "The episode number of this film.", property: :episode_id
      field :openingCrawl, types.String,
        "The opening paragraphs at the beginning of this film.", property: :opening_crawl

      field :director, types.String, "The name of the director of this film."
      field :producers, types[types.String] do
        description "The name(s) of the producer(s) of this film."
        resolve ->(film, _, _) { film.producer.split(", ") }
      end

      field :releaseDate, types.String,
        "The ISO 8601 date format of film release at original creator country.", property: :release_date

      field :created_at, types.String, "The ISO 8601 date format of the time that this resource was created."
      field :updated_at, types.String, "The ISO 8601 date format of the time that this resource was edited."

      # TODO field :species
      # TODO field :starships
      # TODO field :vehicles
      # TODO field :characters
      # TODO field :planets
    end
  end
end
