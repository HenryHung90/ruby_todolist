# frozen_string_literal: true

# TaskController
class TasksController < ApplicationController
  before_action :set_user, expect: %i[new update create]
  before_action :set_task, only: %i[edit show destroy]

  def show
    @task
  end

  def new
    @user = User.find_by(username: params[:user_id])
    @task = @user.tasks.build # 自動設置 user_id 為當前 User 的 id
    @task.tags.build # 初始化 tags 與 task 的關聯
  end

  def edit
    @task
  end

  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(task_params)
    if @task.save
      redirect_to user_path(@user.username), notice: I18n.t('notices.task_created')
    else
      flash[:alert] = I18n.t('notices.task_not_created')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.includes(:tags).find(params[:id]) if params[:id]
    if @task.update(task_params)
      redirect_to user_path(@user.username), notice: I18n.t('notices.task_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to user_path(@user.username), notice: I18n.t('notices.task_destroyed')
  end

  private

  def set_user
    @user = User.find_by(username: params[:user_id])
  end

  def set_task
    @task = @user.tasks.includes(:tags).find(params[:id]) if params[:id]
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time,
                                 tags_attributes: %i[id name _destroy])
  end
end
