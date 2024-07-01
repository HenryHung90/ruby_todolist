# frozen_string_literal: true

module Admin
  # ManageUserController
  class ManageUsersController < ApplicationController
    before_action :authorize_admin
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.all
                   .sort_by_date_or_id(params[:sort_by])
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
      @user.destroy
      redirect_to admin_manage_users_path, notice: I18n.t('notices.user_destroyed')
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    # 檢查是否有權限
    # 進入
    def authorize_admin
      return if current_user&.role_id == 'admin'

      redirect_to root_path alert: 'You are not authorized to access this page.'
    end

    def user_params
      params.require(:user).permit(:username, :name, :password, :role_id)
    end
  end
end
