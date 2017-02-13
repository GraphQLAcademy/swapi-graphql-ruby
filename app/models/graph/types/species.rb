module Graph
  module Types
    Species = GraphQL::ObjectType.define do
      name "Species"
      description "A type of person or character within the Star Wars Universe."

      interfaces [GraphQL::Relay::Node.interface]

      global_id_field :id

      connection :people, Graph::Types::Person.connection_type
      connection :films, Graph::Types::Film.connection_type

      field :name, !types.String, "The name of this species."
      field :classification, types.String, "The classification of this species, such as \"mammal\" or \"reptile\"."
      field :designation, types.String, "The designation of this species, such as \"sentient\"."

      field :averageHeight, types.Float do
        description "The average height of this species in centimeters."
        property :average_height
      end

      field :averageLifespan, types.Int do
        description "The average lifespan of this species in years, null if unknown."
        property :average_lifespan
      end

      field :eyeColors, types[types.String] do
        description "Common eye colors for this species, null if this species does not typically have eyes."
        resolve ->(species, _, _) do
          return unless colors = species.eye_colors
          colors.split(", ")
        end
      end

      field :hairColors, types[types.String] do
        description "Common hair colors for this species, null if this species does not typically have hair."
        resolve ->(species, _, _) do
          return unless colors = species.hair_colors
          colors.split(", ")
        end
      end

      field :skinColors, types[!types.String] do
        description "Common skin colors for this species, null if this species does not typically have skin."
        resolve ->(species, _, _) do
          return unless colors = species.skin_colors
          colors.split(", ")
        end
      end

      field :language, types.String, "The language commonly spoken by this species."
      field :homeworld, Planet, "A planet that this species originates from type." do
        resolve -> (species, _, _) do
          Graph::AssociationLoader.for(::Species, :homeworld).load(species)
        end
      end
    end
  end
end
