module Graph
  module Types
    Starship = GraphQL::ObjectType.define do
      name "Starship"
      model ::Starship
      description "A single transport craft that has hyperdrive capability."

      interfaces [GraphQL::Relay::Node.interface, Graph::Types::TransportInterface]

      global_id_field :id

      # Starship Specific Fields

      field :starshipClass, !types.String do
        description "The class of this starship, such as \"Starfighter\" or \"Deep Space Mobile Battlestation\""
        property :starship_class
      end

      field :hyperdriveRating, !types.Float, "The class of this starships hyperdrive.", property: :hyperdrive_rating

      field :MGLT, !types.Int do
        description "
          The Maximum number of Megalights this starship can travel in a standard hour.
          A \"Megalight\" is a standard unit of distance and has never been
          defined before within the Star Wars universe.
          This figure is only really useful for measuring the difference in speed of starships.
          We can assume it is similar to AU, the distance between our Sun (Sol) and Earth.
        "
        property :mglt
      end

      # Transport Interface Fields

      field :name, !types.String, "The name of this starship. The common name, such as \"Death Star\"."
      field :model, types.String, "The model or official name of this starship. Such as \"T-65 X-wing\" or \"DS-1 Orbital Battle Station\"."

      field :manufacturer, types.String, "The manufacturer of this starship."
      field :costInCredits, types.Float, "The cost of this starship new, in galactic credits", property: :cost_in_credits
      field :length, types.Float, "The length of this starship in meters."
      field :crew, types.String, "The number of personnel needed to run or pilot this starship."
      field :passengers, types.String, "The number of non-essential people this starship can transport."

      field :maxAtmospheringSpeed, types.Int do
        description "The maximum speed of this starship in atmosphere. null
          if this starship is incapable of atmosphering flight."
        property :max_atmosphering_speed
      end

      field :cargoCapacity, types.Float do
        description "The maximum number of kilograms that this starship can transport."
        property :cargo_capacity
      end

      field :consumables, types.String, "The maximum length of time that this starship can provide consumables for its entire crew without having to resupply."
      connection :pilots, Graph::Types::Person.connection_type

      field :createdAt, !types.String,
        "The ISO 8601 date format of the time that this resource was created.", property: :created_at

      field :updatedAt, !types.String,
        "The ISO 8601 date format of the time that this resource was updated.", property: :updated_at
    end
  end
end
