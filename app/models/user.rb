# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :username, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :role_id, inclusion: { in: %w[admin user] }
end
