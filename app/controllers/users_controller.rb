# frozen_string_literal: true

# UserController
class UsersController < ApplicationController

  # sort by date
  SORTABLE_COLUMNS = %w[created_at start_time end_time].freeze

  def index; end

  def show
    @user = User.find(params[:id])

    # 透過 join start end date 排序
    # @tasks = @user.tasks.includes(:tags).order(start_time: :asc) if params[:sort] == 'start_time'

    sort_by = params[:sort].presence_in(SORTABLE_COLUMNS) || 'created_at'
    status = params[:status].presence || 'all'
    title = params[:title].presence || ''

    @tasks = @user.tasks.includes(:tags).order(sort_by => :asc)
    @tasks = @tasks.where(status:) unless status == 'all'
    @tasks = @tasks.where('title ILIKE ?', "%#{title}%")

    # 透過 status 篩選
    # @tasks = @tasks.where(status: params[:status]) if params[:status].present?

    # ILIKE PostgreSQL 特有操作, ILIKE 不區分大小寫
    # ? 佔位字符, 防止 SQL Injection -> 後一個為傳遞給 ? 的實際值
    # @tasks = @tasks.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?

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
