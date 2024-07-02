# frozen_string_literal: true

# middle ware function
class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user
  rescue_from StandardError, with: :render_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_found

  def render_error(exception)
    logger.error(exception.message)
    logger.error(exception.backtrace.join("\n"))
    render file: Rails.public_path.join('500.html').to_s, layout: false, status: :internal_server_error
  end

  def render_no_found
    render file: Rails.public_path.join('404.html').to_s, layout: false, status: :not_found
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    return if current_user

    redirect_to login_path, alert: I18n.t('notices.must_login')
  end
end
