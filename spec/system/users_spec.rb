# require 'rails_helper'


# RSpec.feature "ユーザー管理機能", type: :feature do
#   feature '新規登録機能' do

#     before do 
#       visit new_user_path
#       fill_in "メールアドレス",	with: "test_user@gmail.com" 
#       fill_in "パスワード",	with: "000000" 
#       fill_in "パスワード確認用",	with: "000000" 
#     end

#     it "新規登録画面で名前を入力した時、正常に登録される" do
#       fill_in "名前",	with: "test_user" 
      
#       click_button '登録する'

#       expect(page).to have_selector ".notice", text: "ユーザー登録が完了しました"
#     end

#     it "新規作成画面で名称を入力しなかった時、エラーとなる" do
#       fill_in "名前",	with: "" 
      
#       click_button '登録する'
      
#       within "#error_explanation" do
#         expect(page).to have_content "名前を入力してください"
#       end
#     end
#   end

#   feature 'ログイン・ログアウト機能' do
#     before do 
#       FactoryBot.create(:user)

#       visit new_session_path
#     end
#     context "ログインテスト" do 
#       it "ログインに成功した時" do 
#         fill_in "Email",	with: "testuser@gmail.com"
#         fill_in "Password",	with: "000000"
        
#         click_button 'Log in'
        
#         expect(page).to have_selector ".notice", text: "ログインしました"
#       end
  
#       it "emailを間違えて、ログインに失敗した時" do 
#         fill_in "Email",	with: "test@gmail.com"
#         fill_in "Password",	with: "000000"
        
#         click_button 'Log in'
        
#         expect(page).to have_selector ".danger", text: "ログインに失敗しました"
#       end
#     end
#     context "ログアウトテスト" do 
#       it "ログイン後に、ログアウトした時" do 
#         fill_in "Email",	with: "testuser@gmail.com"
#         fill_in "Password",	with: "000000"
        
#         click_button 'Log in'
#         #ログイン後の動作
#         click_link 'ログアウト'
  
#         expect(page).to have_current_path "/sessions/new"
#       end
#     end

#   end

#   feature '詳細表示機能' do
#     before do 
#       FactoryBot.create(:user)

#       visit new_session_path
#     end
#     it "ユーザー名をクリックするとユーザー詳細画面が見れるかどうか" do
#       fill_in "Email",	with: "testuser@gmail.com"
#       fill_in "Password",	with: "000000"
      
#       click_button 'Log in'
      
#       click_link 'testuser'
      
#       expect(page).to have_content "testuser"
#       expect(page).to have_content "testuser@gmail.com"
#     end
#   end
# end