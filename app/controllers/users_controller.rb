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
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end

end
