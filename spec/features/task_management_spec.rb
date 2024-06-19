require 'rails_helper' # 引入 Rails 測試助手

RSpec.feature "TaskManagement", type: :feature do
  # 定義 feature 測試
  # 創建 User 以及一個 Task 關聯於 User
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  # before do
  #   sign_in user
  # end

  # 測試創建任務
  scenario 'User creates a new task' do
    # 訪問 創建新任務
    visit new_user_task_path(user)

    # 填入 title, content
    fill_in 'Title', with: 'New Task'
    fill_in 'Content', with: 'Task Content'
    # 選擇 medium, pending
    select 'medium', from: 'Priority'
    select 'pending', from: 'Status'
    # 填入時間
    select_datetime 'start', with: Time.now
    select_datetime 'end', with: Time.now + 1.day
    # 創建 Task
    click_button 'Create Task'

    # 預期在畫面上出現字樣
    expect(page).to have_text('Task was successfully created')
  end

  # 測試 update task
  scenario 'User updates a task' do
    visit edit_user_task_path(user, task)

    fill_in 'Title', with: 'Updated Task'
    # 填入時間
    select_datetime 'start', with: Time.now
    select_datetime 'end', with: Time.now + 1.day
    click_button 'Update Task'

    expect(page).to have_text('Task was successfully updated')
  end

  # 測試 delete task
  scenario 'User deletes a task' do
    visit user_task_path(user, task)
    click_link 'Delete'

    expect(page).to have_text('Task was successfully destroyed')
  end

  private

  def select_datetime(label, with:)
    select with.year, from: "task_#{label}_time_1i"
    select Date::MONTHNAMES[with.month], from: "task_#{label}_time_2i"
    select with.day, from: "task_#{label}_time_3i"
    select with.strftime("%H"), from: "task_#{label}_time_4i"
    select with.strftime("%M"), from: "task_#{label}_time_5i"
  end
end
