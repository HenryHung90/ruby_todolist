# frozen_string_literal: true

# UserController
class UsersController < ApplicationController
  layout 'backend', only: [:index]
  # sort by date
  SORTABLE_COLUMNS = %w[created_at start_time end_time].freeze

  def index
    # 透過 join start end date 排序
    # @tasks = @user.tasks.includes(:tags).order(start_time: :asc) if params[:sort] == 'start_time'
  end

  def show
    sort_by = params[:sort_by].presence_in(SORTABLE_COLUMNS) || 'created_at'
    status = params[:status].presence || 'all'
    title = params[:title].presence || ''

    @user = User.find(params[:id])
    # 透過 join start end date 排序
    @tasks = @user.tasks.includes(:tags).order(sort_by => :asc)
    # 透過 status 篩選
    @tasks = @tasks.where(status:) unless status == 'all'
    # ILIKE PostgreSQL 特有操作, ILIKE 不區分大小寫
    # ? 佔位字符, 防止 SQL Injection -> 後一個為傳遞給 ? 的實際值
    @tasks = @tasks.where('title ILIKE ?', "%#{title}%")
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end
end
