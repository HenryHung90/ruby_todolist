# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :user
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  enum priority: { high: 'high', medium: 'medium', low: 'low' }

  accepts_nested_attributes_for :tags, allow_destroy: true
  # scope :complete_before, ->(date) { where('end_time < ?', date) }
  scope :status_done, -> { where(status: 'done') }
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, inclusion: { in: %w[high medium low] }
  validates :status, presence: true, inclusion: { in: %w[pending progress done] }
  validates :start_time, presence: true
  validates :end_time, presence: true
end
