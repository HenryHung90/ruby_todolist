# frozen_string_literal: true

# CreateUsers
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :name, null: false
      t.string :password, null: false
      t.string :role_id, null: false, default: 'user' # 設置預設值為 'user'
      t.timestamps

      t.index :username # 使用 username 做索引值
    end
    check_role_id
  end

  def check_role_id
    # 查詢 role_id 是否合規
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          ALTER TABLE users
          ADD CONSTRAINT role_check CHECK (role_id IN ('admin', 'user'))
        SQL
      end
      dir.down do
        execute <<-SQL.squish
          ALTER TABLE users
          DROP CONSTRAINT role_check
        SQL
      end
    end
  end
end
