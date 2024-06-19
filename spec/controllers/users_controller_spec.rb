require 'rails_helper' # 引入 Rails 測試助手

RSpec.describe UsersController, type: :controller do
  # 定義 Controller 測試
  # 新增一個 User
  let(:user) { create(:user) }

  # 測試 GET show 成功並返回 HTTP status
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
