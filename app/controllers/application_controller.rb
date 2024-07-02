# frozen_string_literal: true

# middle ware function
class ApplicationController < ActionController::Base
  before_action :require_login

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    return if current_user

    redirect_to login_path, alert: I18n.t('notices.must_login')
  end
end
