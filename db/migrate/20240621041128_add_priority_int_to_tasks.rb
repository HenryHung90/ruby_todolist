# frozen_string_literal: true

# Migration
class AddPriorityIntToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :priority_int, :integer, default: 2, null: false
  end
end
