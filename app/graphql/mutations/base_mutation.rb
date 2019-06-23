class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  input_object_class Types::BaseInputObject
end
