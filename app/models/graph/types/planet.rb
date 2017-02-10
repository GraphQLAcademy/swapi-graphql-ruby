module Graph
  module Types
    Planet = GraphQL::ObjectType.define do
      name "Planet"
      description "A planet in the StarWars universe"

      field :id, types.ID

      field :name, types.String
      field :diameter, types.Int
      field :rotationPeriod, types.Int, property: :rotation_period
      field :orbitalPeriod, types.Int, property: :orbital_period
      field :gravity, types.String
      field :population, types.Int
      field :climate, types.String
      field :terrain, types.String
      field :surfaceWater, types.Float, property: :surface_water
    end
  end
end
