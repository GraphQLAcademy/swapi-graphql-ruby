module Graph
  module Types
    Person = GraphQL::ObjectType.define do
      name "Person"
      description "An individual person or character within the Star Wars universe."

      interfaces [GraphQL::Relay::Node.interface]

      global_id_field :id

      connection :starships, Graph::Types::Starship.connection_type
      connection :vehicles, Graph::Types::Vehicle.connection_type
      connection :films, Graph::Types::Film.connection_type

      field :birthYear, types.String,
        "The birth year of the person, using the in-universe standard of BBY or ABY"\
        " - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin"\
        " is a battle that occurs at the end of Star Wars episode IV: A New Hope.",
        property: :birth_year

      field :eyeColor, types.String,
        "The eye color of this person. Will be \"unknown\" if not known or \"n/a\" if the person does not have an eye.",
        property: :eye_color

      field :gender, GenderEnum, "​The gender of this person."
      field :hairColor, types.String,
        "The hair color of this person. Will be \"unknown\" if not known or \"n/a\" if the person does not have hair.",
        property: :hair_color

      field :height, types.Int, "The height of the person in centimeters."
      field :homeworld, Planet, "A planet that this person was born on or inhabits."
      field :mass, types.Int, "The mass of the person in kilograms."
      field :name, !types.String, "The name of this person."
      field :skinColor, types.String, "The skin color of this person.", property: :skin_color
    end
  end
end
