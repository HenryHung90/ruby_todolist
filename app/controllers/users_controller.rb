class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
    @user = User.find_by(id: params[:id])
    @tasks = @user.tasks.includes(:tags) # 預加載 tags 以避免 N+1 查詢問題
  end

  def edit
  end

  def update
  end

  def destory
  end

  def index
  end
end
