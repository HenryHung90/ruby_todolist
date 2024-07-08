# frozen_string_literal: true

# RemoveOldPriorityAndRenameNewPriority
class RemoveOldPriorityAndRenameNewPriority < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :priority, :string
    rename_column :tasks, :priority_int, :priority
  end
end
