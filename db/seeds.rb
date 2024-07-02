# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

User.destroy_all
Task.destroy_all

10.times do
  user = User.create!(
    username: Faker::Internet.unique.username,
    name: Faker::Name.name,
    password: 'password',
    role_id: %w[admin user].sample
  )
  rand(20..30).times do
    Task.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      content: Faker::Lorem.paragraph,
      priority: %w[high medium low].sample,
      status: %w[pending progress done].sample,
      start_time: Faker::Time.backward(days: 14, period: :morning),
      end_time: Faker::Time.forward(days: 14, period: :evening),
      user:
    )
  end
end

puts "Created #{User.count} users with #{Task.count} tasks."
Ｆ
