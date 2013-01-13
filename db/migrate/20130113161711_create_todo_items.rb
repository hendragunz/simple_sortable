class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.integer        :todo_list_id
      t.string         :task_name
      t.string         :detail
      t.integer        :position
      t.timestamps
    end
  end
end
