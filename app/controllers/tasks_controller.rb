class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def new
    @task = @user.tasks.build # 自動設置 user_id 為當前 User 的 id
    @task.tags.build # 初始化 tags 與 task 的關聯
  end

  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      redirect_to user_path(@user), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
    @task
  end

  def edit
    @task
  end

  def update
    if @task.update(task_params)
      redirect_to user_task_path(@user, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to user_path(@user), notice: 'Task was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_task
    @task = @user.tasks.includes(:tags).find(params[:id]) if params[:id]
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time, tags_attributes: [:id, :name, :_destroy])
  end
end
