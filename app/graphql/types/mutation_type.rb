module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
