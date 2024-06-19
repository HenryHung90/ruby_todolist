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

    # 查詢 role_id 是否合規
    execute "ALTER TABLE users ADD CONSTRAINT role_check CHECK (role_id IN ('admin', 'user'))"
  end
end
