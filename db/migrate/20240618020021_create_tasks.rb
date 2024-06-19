# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :priority, default: 'low'
      t.string :status, default: 'pending'
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end

    # 檢查 priority 與 status 是否合規
    execute "ALTER TABLE tasks ADD CONSTRAINT priority_check CHECK (priority IN ('high', 'medium', 'low'))"
    execute "ALTER TABLE tasks ADD CONSTRAINT status_check CHECK (status IN ('pending', 'progress', 'done'))"
  end
end
