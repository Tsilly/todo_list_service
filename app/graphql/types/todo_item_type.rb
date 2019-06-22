module Types
  class TodoItemType < Types::BaseObject
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :completed_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
