# frozen_string_literal: true

module Admin
  # ManageTaskController
  class ManageTasksController < ApplicationController
    before_action :authorize_admin
    before_action :set_task, except: %i[create new]
    layout 'backend'
    # sort by date
    SORTABLE_COLUMNS = %w[created_at start_time end_time priority].freeze

    def index
      @tasks = @tasks.sort_by_date_and_priority(params[:sort])
                     .filter_by_status(params[:status])
                     .filter_by_title(params[:title])
                     .page(params[:page]).per(10)
      @users = User.all
    end

    def show
      @task
    end

    def new
      @task = Task.new
    end

    def edit
      @task = @task.find(params[:id])
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
      @task = @tasks.find(params[:id])
      if @task.update(task_params)
        redirect_to admin_manage_task_path(@task), notice: I18n.t('notices.task_updated')
      else
        render :edit
      end
    end

    def destroy
      @task = @tasks.find(params[:id])
      @task.destroy
      redirect_to admin_manage_tasks_path, notice: I18n.t('notices.task_destroyed')
    end

    private

    def set_task
      @tasks = Task.includes(:tags)
    end

    def authorize_admin
      return if current_user&.role_id == 'admin'

      redirect_to root_path, alert: I18n.t('notices.auth_denied')
    end

    def task_params
      params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time)
    end
  end
end
