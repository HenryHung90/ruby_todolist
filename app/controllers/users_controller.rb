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
    @user = User.find_by(username: params[:id])
    return unless @user.tasks

    @tasks = @user.tasks
                  .includes(:tags)
                  .sort_by_date_and_priority(params[:sort])
                  .filter_by_status(params[:status])
                  .filter_by_title(params[:title])
                  .filter_by_tag(params[:tag])
                  .page(params[:page]).per(10)
    @tags = get_all_user_tags(@tasks)
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destory; end

  private

  def get_all_user_tags(tasks)
    tags = []
    tasks.each do |task|
      task.tags.each do |tag|
        tags << tag.name
      end
    end
    tags.uniq
  end
end
