class TodoItem < ApplicationRecord
  belongs_to :todo_list
  validates :content, presence: true
end
