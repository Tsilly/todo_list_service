module Mutations
  class CreateUser < Mutations::BaseMutation
    null true

    graphql_name 'Signup'

    argument :auth_attributes, Types::UserAuthAttributes, required: true
    argument :name, String, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(name:, auth_attributes:)
      user = User.new(
        name: name,
        email: auth_attributes[:email],
        password: auth_attributes[:password]
      )

      response = {}
      response[:errors] = user.save! ? [] : user.errors.full_messages
      response[:user] = user
      response
    end
  end
end
