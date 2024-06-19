# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
end
