# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :user
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  accepts_nested_attributes_for :tags, allow_destroy: true
  # scope :complete_before, ->(date) { where('end_time < ?', date) }
  # scope :status_done, -> { where(status: 'done') }
  # 透過 join/start/end date or priority 排序
  scope :sort_by_date_and_priority, lambda { |sort_by|
    sort_by = sort_by.presence_in(%w[created_at start_time end_time priority]) || 'created_at'
    return order(sort_by => :asc) if sort_by != 'priority'

    order(:priority)
  }
  scope :filter_by_status, lambda { |status|
    status = status.presence || 'all'
    return if status == 'all'

    where(status:)
  }
  scope :filter_by_title, lambda { |title|
    title = title.presence || ''
    where('title ILIKE ?', "%#{title}%")
  }

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :priority, presence: true, inclusion: { in: %w[high medium low] }
  validates :status, presence: true, inclusion: { in: %w[pending progress done] }
  validates :start_time, presence: true
  validates :end_time, presence: true
  enum priority: { high: 1, medium: 2, low: 3 }
end
