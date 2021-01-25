require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # user_a = FactoryBot.create(:user, username: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task)

    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: 'a@example.com'
        fill_in 'user[password]', with: 'password'
        click_button 'commit'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content 'rubyの勉強をする'
      end
    end
  end
end


