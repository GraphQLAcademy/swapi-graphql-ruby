module Graph
  module Types
    GenderEnum = GraphQL::EnumType.define do
      name "Genders"
      description "Possible Genders of a character"
      value("MALE", value: "male")
      value("FEMALE", value: "female")
      value("HERMAPHRODITE", value: "hermaphrodite")
      value("NONE", value: "none")
      value("NOT_AVAILABLE", value: "n/a")
    end
  end
end
