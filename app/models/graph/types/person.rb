module Graph
  module Types
    Person = GraphQL::ObjectType.define do
      name "Person"
      description "A character in the StarWars universe"

      field :id, types.ID

      field :birthYear, types.String, property: :birth_year
      field :eyeColor, types.String, property: :eye_color
      field :gender, GenderEnum
      field :hairColor, types.String, property: :hair_color
      field :height, types.Int
      field :mass, types.Int
      field :name, types.String
      field :skinColor, types.String
    end
  end
end
