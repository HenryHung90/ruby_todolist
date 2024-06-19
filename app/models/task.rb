# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  accepts_nested_attributes_for :tags, allow_destroy: true
  # scope :complete_before, ->(date) { where('end_time < ?', date) }
  scope :status_done, -> { where(status: 'done') }
end
