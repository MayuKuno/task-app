require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user, username:'UserA', email: 'a@example.com') }

  describe 'Sign-ups' do
    before do 
      visit new_user_path
      fill_in "user[email]",	with: "test_user@example.com" 
      fill_in "user[password]",	with: "password" 
      fill_in "user[password_confirmation]",	with: "password" 
    end

    it "signs up successfully with name" do
      fill_in "user[username]",	with: "testuser" 
      click_button 'commit'
      expect(page).to have_selector ".notice", text: "The user has been registerd!"

    end

    it "signs up unsuccessfully without name" do
      fill_in "user[username]",	with: "" 
      click_button 'commit'
      within ".error" do
        expect(page).to have_content "Usernameを入力してください"
      end
    end
  end

  describe 'Sign-ins・Sign-out' do
    before do 
      visit login_path
    end
    context "sign-in successfully" do 
      it "signs in" do 
        fill_in "session[email]",	with: user.email
        fill_in "session[password]",	with: user.password
        click_button 'commit'
        expect(page).to have_selector '.notice', text: 'Logged in!'
      end
  
      it "signs in unsuccessfully without valid email" do 
        fill_in "session[email]",	with: user.email
        fill_in "session[password]",	with: 'wrongpassword'
        click_button 'commit'
        expect(page).to have_selector ".alert", text: "Wrong password or username"
      end
    end

    context "sign-out successfully" do 
      it "sign out after login" do 
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

  describe 'User#show' do
    before do 
      FactoryBot.create(:user)
      visit login_path
    end
    it "user sees the detail info" do
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