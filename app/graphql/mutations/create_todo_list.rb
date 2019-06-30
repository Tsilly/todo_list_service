module Mutations
  class CreateTodoList < Mutations::BaseMutation
    null true

    graphql_name 'CreateTodoList'

    argument :title, String, required: true
    argument :description, String, required: false

    field :todoList, Types::TodoListType, null: true
    field :errors, [String], null: false
    
    def resolve(title:, description: nil)
      todo_list = TodoList.new(
        title: title,
        description: description,
        user: context[:current_user]
      )

      response = {}

      response[:errors] = todo_list.save! ? [] : todo_list.errors.full_messages
      response[:todoList] = todo_list
      response
    end
  end
end
