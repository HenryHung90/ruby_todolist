# frozen_string_literal: true

module Admin
  # ManageUserController
  class ManageUsersController < ApplicationController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_manage_user_path(@user), notice: I18n.t('notices.user_created')
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_manage_user_path(@user), notice: I18n.t('notices.task_updated')
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_manage_users_path, notice: I18n.t('notices.user_destroyed')
    end

    private

    def user_params
      params.require(:user).permit(:username, :name, :password, :role_id)
    end
  end
end
