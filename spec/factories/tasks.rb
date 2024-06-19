FactoryBot.define do
  # 創建 task 工廠
  # association :user 設定該任務屬於一個 user
  # title, content 隨機生成
  # priority, status 隨機挑選
  # start_time, end_time 隨機挑選
  factory :task do
    association :user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    priority { %w[low medium high].sample }
    status { %w[pending progress done].sample }
    start_time { Faker::Time.between(from: DateTime.now - 5, to: DateTime.now) }
    end_time { Faker::Time.between(from: start_time, to: start_time + 10.days) }
  end
end
