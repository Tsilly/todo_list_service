module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :todo_lists, [Types::TodoListType], null: true
  end
end
