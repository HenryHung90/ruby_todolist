# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find_by(id: params[:id])
    @tasks = @user.tasks.includes(:tags)
    # @tasks = @user.tasks.includes(:tags).status_done
    # @tasks = @user.tasks.includes(:tags).complete_before(Date.new(2024, 7, 1)) # 預加載 tags 以避免 N+1 查詢問題
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end
end
