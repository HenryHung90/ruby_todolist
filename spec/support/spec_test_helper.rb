# frozen_string_literal: true

module SpecTestHelper
  def login_user(user)
    post login_path, params: { username: user.username, password_digest: user.password_digest }
  end
end
