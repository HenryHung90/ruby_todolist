# AddIndexToTasks
class AddIndexToTasks < ActiveRecord::Migration[7.1]
  def change
    add_index :tasks, :title
    add_index :tasks, :status
    add_index :tasks, :priority
    add_index :tasks, :created_at
    add_index :tasks, :end_time
  end
end
