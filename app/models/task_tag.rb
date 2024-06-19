# frozen_string_literal: true

# Task Tag Model
class TaskTag < ApplicationRecord
  belongs_to :task
  belongs_to :tag
end
