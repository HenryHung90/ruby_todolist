# frozen_string_literal: true

module Admin
  # ManageTaskController
  class ManageTasksController < ApplicationController
    layout 'backend'
    # sort by date
    SORTABLE_COLUMNS = %w[created_at start_time end_time priority].freeze

    def index
      @tasks = filter_tasks(Task).page(params[:page]).per(10)
      @users = User.all
    end

    def show
      @task = Task.find(params[:id])
    end

    def new
      @task = Task.new
    end

    def edit
      @task = Task.find(params[:id])
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        redirect_to admin_manage_task_path(@task), notice: I18n.t('notices.task_created')
      else
        render :new
      end
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to admin_manage_task_path(@task), notice: I18n.t('notices.task_updated')
      else
        render :edit
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to admin_manage_tasks_path, notice: I18n.t('notices.task_destroyed')
    end

    private

    # 篩選 Task
    def filter_tasks(tasks)
      tasks = sort_tasks(tasks)
      tasks = filter_by_status(tasks)
      filter_by_title(tasks)
    end

    # 透過 join start end date 排序
    def sort_tasks(tasks)
      sort_by = params[:sort_by].presence_in(SORTABLE_COLUMNS) || 'created_at'
      return tasks.order(sort_by => :asc) if sort_by != 'priority'

      tasks.order(Arel.sql("CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END") => :asc)
    end

    # 透過 status 篩選
    def filter_by_status(tasks)
      status = params[:status].presence || 'all'
      return tasks if status == 'all'

      tasks.where(status:)
    end

    # ILIKE PostgreSQL 特有操作, ILIKE 不區分大小寫
    # ? 佔位字符, 防止 SQL Injection -> 後一個為傳遞給 ? 的實際值
    def filter_by_title(tasks)
      title = params[:title].presence || ''
      tasks.where('title ILIKE ?', "%#{title}%")
    end

    def task_params
      params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time)
    end
  end
end
