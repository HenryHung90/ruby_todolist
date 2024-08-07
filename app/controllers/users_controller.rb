# frozen_string_literal: true

# UserController
class UsersController < ApplicationController
  layout 'backend', only: [:index]
  # sort by date
  SORTABLE_COLUMNS = %w[created_at start_time end_time priority].freeze

  def index
    # 透過 join start end date 排序
    # @tasks = @user.tasks.includes(:tags).order(start_time: :asc) if params[:sort] == 'start_time'
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
                  .sort_by_date_and_priority(params[:sort])
                  .filter_by_status(params[:status])
                  .filter_by_title(params[:title])
                  .page(params[:page]).per(10)
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end

  # 篩選 Task
  def filter_tasks(tasks)
    tasks = sort_tasks(tasks)
    tasks = filter_by_status(tasks)
    filter_by_title(tasks)
  end

  # 透過 join start end date 排序
  def sort_tasks(tasks)
    sort_by = params[:sort_by].presence_in(SORTABLE_COLUMNS) || 'created_at'
    tasks.order(sort_by => :asc)
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
end
