require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  let(:user) { FactoryBot.create(:user, username:'UserA', email: 'a@example.com') }

  describe '新規登録機能' do
    before do 
      visit new_user_path
      fill_in "user[email]",	with: "test_user@example.com" 
      fill_in "user[password]",	with: "password" 
      fill_in "user[password_confirmation]",	with: "password" 
    end

    it "新規登録画面で名前を入力した時、正常に登録される" do
      fill_in "user[username]",	with: "testuser" 
      click_button 'commit'
      expect(page).to have_selector ".notice", text: "The user has been registerd!"

    end

    it "新規作成画面で名称を入力しなかった時、エラーとなる" do
      fill_in "user[username]",	with: "" 
      click_button 'commit'
      within ".error" do
        expect(page).to have_content "Usernameを入力してください"
      end
    end
  end

  describe 'ログイン・ログアウト機能' do
    before do 
      visit login_path
    end
    context "ログインテスト" do 
      it "ログインに成功した時" do 
        fill_in "session[email]",	with: user.email
        fill_in "session[password]",	with: user.password
        click_button 'commit'
        expect(page).to have_selector '.notice', text: 'Logged in!'
      end
  
      it "emailを間違えて、ログインに失敗した時" do 
        fill_in "session[email]",	with: user.email
        fill_in "session[password]",	with: 'wrongpassword'
        click_button 'commit'
        expect(page).to have_selector ".alert", text: "Wrong password or username"
      end
    end

    context "ログアウトテスト" do 
      it "ログイン後に、ログアウトした時" do 
        fill_in "session[email]",	with: user.email
        fill_in "session[password]",	with: user.password
        click_button 'commit'
        find(".mobile-menu__btn").click
        click_link 'ログアウト'
        expect(page).to have_current_path root_path
        expect(page).to have_selector '.notice', text: 'Logged out!'

      end
    end

  end

  describe '詳細表示機能' do
    before do 
      FactoryBot.create(:user)
      visit login_path
    end
    it "ユーザー名をクリックするとユーザー詳細画面が見れるかどうか" do
      fill_in "session[email]",	with: user.email
      fill_in "session[password]",	with: user.password
      click_button 'commit'
      find(".mobile-menu__btn").click

      click_link user.username
      
      expect(page).to have_current_path user_path(user)
      expect(page).to have_content user.username
      expect(page).to have_content user.email
    end
  end
end