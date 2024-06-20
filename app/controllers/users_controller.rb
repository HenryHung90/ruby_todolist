# frozen_string_literal: true

# UserController
class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])

    @tasks = @user.tasks.includes(:tags).order(created_at: :asc) if params[:sort] == 'join_date' || params[:sort] == nil
    @tasks = @user.tasks.includes(:tags).order(start_time: :asc) if params[:sort] == 'start_date'
    @tasks = @user.tasks.includes(:tags).order(end_time: :asc) if params[:sort] == 'end_date'
    # @tasks = Task.order(created_at: :asc)
    # @tasks = @user.tasks.includes(:tags).status_done
    # @tasks = @user.tasks.includes(:tags).complete_before(Date.new(2024, 7, 1)) # 預加載 tags 以避免 N+1 查詢問題
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end
end
