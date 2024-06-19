# frozen_string_literal: true

# CreateTasks
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
    check_priority_and_status
  end

  private

  # 檢查 priority 與 status 是否合規
  def check_priority_and_status
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          ALTER TABLE tasks
          ADD CONSTRAINT priority_check CHECK (priority IN ('high', 'medium', 'low'))
        SQL
        execute <<-SQL.squish
          ALTER TABLE tasks
          ADD CONSTRAINT status_check CHECK (status IN ('pending', 'progress', 'done'))
        SQL
      end
      dir.down do
        execute <<-SQL.squish
          ALTER TABLE tasks
          DROP CONSTRAINT priority_check
        SQL
        execute <<-SQL.squish
          ALTER TABLE tasks
          DROP CONSTRAINT status_check
        SQL
      end
    end
  end
end
