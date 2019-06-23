module Types
  class UserType < Types::BaseObject
    graphql_name 'User'

    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :todo_lists, [Types::TodoListType], null: true
  end
end
