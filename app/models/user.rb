# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :role_id, inclusion: { in: %w[admin user] }
end
