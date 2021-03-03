require 'rails_helper'

RSpec.describe "管理者によるユーザー管理機能", type: :system do
  let(:user_admin){FactoryBot.create(:user,admin: true)}
  let(:user_notadmin){FactoryBot.create(:user,admin: false)}


  before do 
    visit login_path
    fill_in "session[email]",	with: login_user.email
    fill_in "session[password]",	with: login_user.password
    click_button 'commit'
  end


  describe '管理画面へのアクセス' do
    before do
      find(".mobile-menu__btn").click
    end

    context "管理者がログインしている時" do
      let(:login_user) { user_admin }
      it "管理画面へのリンクが表示される" do
        expect(page).to have_content 'Only for admin'
        click_link 'Only for admin'
        expect(page).to have_current_path admin_users_path
      end
    end

    context "一般ユーザーがログインしている時" do
      let(:login_user) { user_notadmin }
      it "管理画面へのリンクが表示されない" do
        expect(page).not_to have_content 'Only for admin'
      end
    end
  end


  describe '管理者の新規登録機能' do
    let(:login_user) { user_admin }

    before do
      find(".mobile-menu__btn").click
      click_link 'Only for admin'
      find(".plus").click
    end

    context "登録時に管理者権限にチェックを入れる" do
      it "新規管理者ユーザーは、ユーザー管理画面へアクセスできる" do
        fill_in "user[username]",	with: "user_admin1" 
        fill_in "user[email]",	with: "user_admin1@example.com" 
        fill_in "user[password]",	with: "password" 
        fill_in "user[password_confirmation]",	with: "password" 
        check 'user[admin]'
        click_button 'commit'
        find(".mobile-menu__btn").click
        click_link 'ログアウト'


        visit login_path
        fill_in "session[email]",	with: "user_admin1@example.com"
        fill_in "session[password]",	with: "password"
        click_button 'commit'
        find(".mobile-menu__btn").click
        expect(page).to have_content 'Only for admin'
      end
    end
  end



  feature '管理者の編集機能' do
    let(:login_user) { user_admin }
    let(:user_admin_edit){FactoryBot.create(:user, username:'admin1', email: 'admin1@example.com', admin: true)}

    context "管理者が一般ユーザーの編集画面へ" do
      before do
        visit edit_user_path(user_admin_edit)
        fill_in "user[username]",	with: "edit_admin" 
        uncheck 'user[admin]'
        click_button 'commit'
      end

      it "名前を編集すると変更されているかどうか" do
        expect(page).to have_content 'edit_admin'
        expect(page).to have_content '管理者ではありません'

        find(".mobile-menu__btn").click
        click_link 'ログアウト'


        visit login_path
        fill_in "session[email]",	with: user_admin_edit.email
        fill_in "session[password]",	with: user_admin_edit.password
        click_button 'commit'
        find(".mobile-menu__btn").click
        expect(page).to have_no_content 'Only for admin'
        visit user_path(user_admin_edit)

        

      end

    end
  end

  feature '削除機能' do
    let(:login_user) { user_admin }
    let(:user_admin_edit){FactoryBot.create(:user, username:'admin1', email: 'admin1@example.com', admin: true)}


    context "管理者が最後じゃなかった場合" do
      before do
        visit user_path(user_admin_edit)
        find(".modal-open-btn").click
        find("#delete-comformation-btn").click
      end

      it "削除ボタンを押した時に削除されているかどうか" do
        expect(page).not_to have_content 'admin1@example.com'
      end
    end


  end
end








#   feature 'ユーザー詳細情報' do
#     scenario 'ユーザー詳細情報を閲覧する' do
#       first(:link, '詳細').click

#       expect(page).to have_content user.name
#       expect(page).to have_content user.email
#       expect(page).to have_content task.name
#       expect(page).to have_content task.description
#     end
#   end
# end