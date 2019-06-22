module Types
  class TodoListType < Types::BaseObject
    field :title, String, null: false
    field :description, String, null: false
    field :todo_items, [Types::TodoItemType], null: true
  end
end
