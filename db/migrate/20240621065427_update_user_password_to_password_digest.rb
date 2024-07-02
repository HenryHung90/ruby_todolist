# frozen_string_literal: true

# Update User Password To Password Digest
class UpdateUserPasswordToPasswordDigest < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :password, :password_digest
  end
end
