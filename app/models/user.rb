# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  scope :sort_by_date_or_id, lambda { |sort_by|
    sort_by = sort_by.presence_in(%w[id created_at updated_at]) || 'id'
    order(sort_by => :asc)
  }

  scope :filter_by_role, lambda { |role_id|
    return if role_id.nil?

    where(role_id:)
  }

  validates :username, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :role_id, inclusion: { in: %w[admin user] }
end
