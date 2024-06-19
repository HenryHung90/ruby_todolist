# frozen_string_literal: true

require 'rails_helper' # 引入 Rails 測試助手

RSpec.describe TasksController, type: :controller do
  # 定義 Controller 測試
  # 用 FacktoryBot 創建 User
  let(:user) { create(:user) }
  # 創建 task 關聯至該 User
  let(:task) { create(:task, user:) }

  # before do
  #   sign_in user
  # end

  # 測試 GET new 是否成功，並返回 HTTP status
  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      allow(controller).to receive(:render) { nil } # 禁用實際視圖渲染
    end
  end

  # 測試 POST create 是否成功，並有創建任務
  describe 'POST #create' do
    it 'creates a new task' do
      expect do
        post :create, params: { user_id: user.id, task: attributes_for(:task) }
      end.to change(Task, :count).by(1)
    end
  end

  # 測試 GET show 是否返回 HTTP status
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { user_id: user.id, id: task.id }
      expect(response).to have_http_status(:success)
    end
  end

  # 測試 PATCH update 是否正確修改
  describe 'PATCH #update' do
    it 'updates the task' do
      patch :update, params: { user_id: user.id, id: task.id, task: { title: 'Updated Title' } }
      task.reload
      expect(task.title).to eq('Updated Title')
    end
  end

  # 測試 DELETE destroy 是否正確刪除
  describe 'DELETE #destroy' do
    it 'deletes the task' do
      task
      expect do
        delete :destroy, params: { user_id: user.id, id: task.id }
      end.to change(Task, :count).by(-1)
    end
  end
end
