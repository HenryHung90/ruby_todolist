class PageController < ApplicationController

  def index
  end

  def home
    @user_info = User.find_by(id: params[:id])
    @tasks = @user_info.tasks.includes(:tags) # 預加載 tags 以避免 N+1 查詢問題
  end

  def admin
  end
end
