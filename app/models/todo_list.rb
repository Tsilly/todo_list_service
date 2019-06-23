class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy
  validates :title, presence: true
end
