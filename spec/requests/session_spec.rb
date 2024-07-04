# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }
  let(:task) { create(:task, 10, user:) }

  describe 'GET /login' do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /login' do
    context 'with valid credentials' do
      it "logs the user in and redirects to the user's page" do
        post login_path, params: { username: user.username, password: user.password }
        expect(response).to redirect_to(user_path(user.username))
        follow_redirect!
        # expect(response).to have_text(I18n.t('notices.login_success'))
      end
    end

    context 'with invalid credentials' do
      it 'renders the login page with an error message' do
        post login_path, params: { username: user.username, password: 'wrongpassword' }
        expect(response).to render_template(:new)
        # expect(response).to have_text(I18n.t('notices.login_failed'))
      end
    end
  end

  describe 'DELETE /logout' do
    it 'logs the user out and redirects to the login page' do
      delete logout_path
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response).to render_template(:new)
      # expect(response).to have_text(I18n.t('notices.logout_success'))
    end
  end
end
