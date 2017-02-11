module Graph
  module Types
    Planet = GraphQL::ObjectType.define do
      name "Planet"
      description "A large mass, planet or planetoid in the Star Wars Universe, at the time of 0 ABY."

      field :id, types.ID, "The ID of the person."

      field :name, types.String, "The name of this planet."
      field :diameter, types.Int, "The diameter of this planet in kilometers."

      field :rotationPeriod, types.Int,
        "The number of standard hours it takes for this planet to complete a single rotation on its axis.",
        property: :rotation_period

      field :orbitalPeriod, types.Int,
        "The number of standard days it takes for this planet to complete a single orbit of its local star.",
        property: :orbital_period

      field :gravity, types.String,
        "A number denoting the gravity of this planet, where \"1\" is normal or 1 standard G."\
        " \"2\" is twice or 2 standard Gs. \"0.5\" is half or 0.5 standard Gs."

      field :population, types.Float, "The average population of sentient beings inhabiting this planet."
      field :climate, types.String, "The climate of this planet."
      field :terrain, types.String, "The terrain of this planet."

      field :surfaceWater, types.Float,
        "The percentage of the planet surface that is naturally occuring water or bodies of water.",
        property: :surface_water
    end
  end
end
