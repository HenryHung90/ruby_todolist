# frozen_string_literal: true

# change log
class AddValidatesToUserAndTask < ActiveRecord::Migration[7.1]
  def change
    user_changes
    task_changes
  end

  private

  def user_changes
    # 確保 column 有值
    change_column_null :users, :username, false
    change_column_null :users, :name, false
    change_column_null :users, :password, false
    change_column_null :users, :role_id, false
  end

  def task_changes
    # 確保 column 有值
    change_column_null :tasks, :title, false
    change_column_null :tasks, :content, false
    change_column_null :tasks, :priority, false
    change_column_null :tasks, :status, false
    change_column_null :tasks, :start_time, false
    change_column_null :tasks, :end_time, false
  end
end
