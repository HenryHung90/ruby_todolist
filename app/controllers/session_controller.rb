# frozen_string_literal: true

# Login System
class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    redirect_to user_path(current_user.username) if current_user.present?
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.username), notice: I18n.t('notices.login_success')
    else
      flash[:alert] = I18n.t('notices.login_failed')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: I18n.t('notices.logout_success')
  end
end
