class Task < ApplicationRecord
  belongs_to :user
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  accepts_nested_attributes_for :tags, allow_destroy: true
end
