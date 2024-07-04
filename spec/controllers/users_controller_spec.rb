# frozen_string_literal: true

require 'rails_helper' # 引入 Rails 測試助手

RSpec.describe UsersController, type: :controller do
  # 定義 Controller 測試
  # 新增一個 User
  let(:user) { create(:user) }
  # 創建 tasks 關聯至該 User
  let(:tasks) { create_list(:task, 10, user:) }
  
  before do
    request.session[:user_id] = user.id
  end

  # 測試 GET show 成功並返回 HTTP status
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.username }
      expect(response).to have_http_status(:success)
    end
  end
  # 測試 GET show 查詢功能是否正常
  describe 'GET #show' do
    context 'with valid params' do
      # 測試第一次進入 user page 後是否預設為用 created_at 排序
      it "assigns the user's task page" do
        get :show, params: { id: user.username }
        expect(assigns(:tasks)).to match_array(user.tasks.order(created_at: :asc))
      end
      # 測試用 end_time 進行排序
      it 'sorts tasks by end_time' do
        get :show, params: { id: user.username, sort_by: 'end_time' }
        expect(assigns(:tasks)).to match_array(user.tasks.order(end_time: :asc))
      end
      # 測試用 priority 進行篩選
      it 'filters tasks by priority' do
        get :show, params: { id: user.username, sort_by: 'priority' }
        expect(assigns(:tasks)).to match_array(user.tasks.order(:priority))
      end
      # 測試用 status 進行篩選
      it 'filters tasks by status' do
        status = tasks.first.status
        get :show, params: { id: user.username, status: }
        expect(assigns(:tasks)).to match_array(user.tasks.where(status:))
      end
      # 測試用 title 進行篩選
      it 'filters tasks by title' do
        title = tasks.first.title.chars.first
        get :show, params: { id: user.username, title: }
        expect(assigns(:tasks)).to match_array(user.tasks.where('title ILIKE ?', "%#{title}%"))
      end
      # 測試用 end_time 排序, 並篩出 status = pending, title = 'A'
      it 'sort by end_time and filters by status and title' do
        title = tasks.first.title.chars.first
        status = tasks.third.status
        sort_by = 'end_time'

        get :show, params: { id: user.username, sort_by:, title:, status: }
        expect(assigns(:tasks)).to match_array(user.tasks
                                                   .where(status:)
                                                   .where('title ILIKE ?', "%#{title}%")
                                                   .order(end_time: :asc))
      end
    end
  end
end
