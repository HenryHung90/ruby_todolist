FactoryBot.define do
  # 定義 User 測試工廠
  # 生成隨機用戶登入名稱、用戶名稱
  # 密碼設定固定
  # 設定角色為 user
  factory :user do
    username { Faker::Internet.username }
    name { Faker::Name.name }
    password { 'password' }
    role_id { 'user' }
  end
end
