# frozen_string_literal: true

module Admin
  # ManageUserController
  class ManageUsersController < ApplicationController
    before_action :authorize_admin
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.sort_by_date_or_id(params[:sort_by])
                   .filter_by_role(params[:role])
                   .page(params[:page]).per(10)
    end

    def show
      @user
    end

    def new
      @user = User.new
    end

    def edit
      @user
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_manage_user_path(@user), notice: I18n.t('notices.user_created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      # 使用 user_params 的複製品進行處理
      updated_params = user_params.dup
      if updated_params[:password].blank?
        updated_params.delete(:password)
        updated_params.delete(:password_confirmation)
      end
      if @user.update(updated_params)
        redirect_to admin_manage_users_path, notice: I18n.t('notices.user_updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if User.where(role_id: 'admin').count <= 1 && @user.role_id == 'admin'
        return redirect_to admin_manage_users_path, alert: I18n.t('notices.delete_admin_denied')
      end

      if @user.destroy
        redirect_to admin_manage_users_path, notice: I18n.t('notices.user_destroyed')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    # 檢查是否有權限
    def authorize_admin
      return if current_user&.role_id == 'admin'

      redirect_to root_path alert: I18n.t('notices.auth_denied')
    end

    def user_params
      params.require(:user).permit(:username, :name, :password, :role_id)
    end
  end
end
