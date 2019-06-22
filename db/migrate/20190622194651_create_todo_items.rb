class CreateTodoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_items do |t|
      t.belongs_to :todo_list, foreign_key: true, index: true
      t.string :content
      t.datetime :completed_at
      t.integer :todo_list_id

      t.timestamps
    end
    add_index :todo_items, %i[todo_list_id content]
  end
end
