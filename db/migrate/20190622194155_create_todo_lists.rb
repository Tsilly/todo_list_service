class CreateTodoLists < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_lists do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :todo_lists, %i[title description]
  end
end
