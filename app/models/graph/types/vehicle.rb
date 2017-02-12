module Graph
  module Types
    Vehicle = GraphQL::ObjectType.define do
      name "Vehicle"
      description "A single transport craft that has hyperdrive capability."

      interfaces [GraphQL::Relay::Node.interface, Graph::Types::TransportInterface]

      global_id_field :id

      # Vehicle Specific Fields

      field :vehicleClass, types.String do
        description "The class of this vehicle, such as \"Wheeled\" or \"Repulsorcraft\"."
        property :vehicle_class
      end

      # Transport Interface Fields
      field :name, types.String, "The name of this vehicle. The common name, such as \"Sand Crawler\" or \"Speeder bike\""
      field :model, types.String, "The model or official name of this vehicle. Such as \"All-Terrain Attack Transport\"."

      field :manufacturer, types.String, "The manufacturer of this vehicle."
      field :costInCredits, types.Float, "The cost of this vehicle new, in galactic credits", property: :cost_in_credits
      field :length, types.Float, "The length of this vehicle in meters."
      field :crew, types.String, "The number of personnel needed to run or pilot this vehicle."
      field :passengers, types.String, "The number of non-essential people this vehicle can transport."

      field :maxAtmospheringSpeed, types.Int do
        description "The maximum speed of this vehicle in atmosphere. null
          if this vehicle is incapable of atmosphering flight."
        property :max_atmosphering_speed
      end

      field :cargoCapacity, types.Float do
        description "The maximum number of kilograms that this vehicle can transport."
        property :cargo_capacity
      end

      field :consumables, types.String, "The maximum length of time that this vehicle can provide consumables for its entire crew without having to resupply."
      connection :pilots, Graph::Types::Person.connection_type

      field :created_at, types.String, "The ISO 8601 date format of the time that this resource was created."
      field :updated_at, types.String, "The ISO 8601 date format of the time that this resource was updated."
    end
  end
end
