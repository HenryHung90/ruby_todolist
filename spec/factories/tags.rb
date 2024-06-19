# frozen_string_literal: true

FactoryBot.define do
  # 創建 Tag 工廠
  # name 隨機生成
  factory :tag do
    name { Faker::Lorem.word }
  end
end
