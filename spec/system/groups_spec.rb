require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  let(:user_a) { FactoryBot.create(:user, username:'userA', email: 'a@example.com') } #userAを作成
  let(:user_b) { FactoryBot.create(:user, username:'userB', email: 'b@example.com') } #userBを作成
  let(:user_c) { FactoryBot.create(:user, username:'userC', email: 'c@example.com') } #userCを作成
  let!(:group_a){ FactoryBot.create(:group, name: 'グループA', users: [user_a, user_b]) }

  before do
    visit login_path #ログイン画面にアクセスする
    fill_in 'session[email]', with: login_user.email #メールアドレスを入力する
    fill_in 'session[password]', with: login_user.password #パスワードを入力する
    click_button 'commit' #「ログインする」ボタンをおす
  end


  shared_examples_for 'userAが所属しているグループが表示される' do
    it { expect(page).to have_content 'グループA' }
  end

  describe '一覧表示機能' do
    before do
      visit groups_path
    end

    context 'userAがログインしている時' do
      let(:login_user) { user_a }
      it_behaves_like 'userAが所属しているグループが表示される'
    end

    context 'userCがログインしている時' do
      let(:login_user) { user_c }
      it 'userCが所属していないグループが表示されない' do
        expect(page).to have_no_content 'グループA'#userAが作成したタスクの名称が画面上に表されていないことを確認
      end
    end
  end




  describe '詳細表示機能' do
    let(:login_user) { user_a }

    before do
      visit groups_path
      click_on 'グループA'
    end

    context 'userAがログインしているとき' do
      it 'グループの名前が表示される'do
        expect(page).to have_content 'グループA'
      end
    end
  end


  describe '新規作成機能' do
    let(:login_user) { user_c }
    let(:group_name) { 'グループの名前' }

    before do
      visit new_group_path
      fill_in 'group[name]', with: group_name
      fill_in 'searchinput', with: user_a.username
      find(".btns--add").click
      fill_in 'searchinput', with: user_b.username
      find(".btns--add").click
      click_button 'commit'
    end

    context '新規作成画面で名称を入力した時' do
      it '正常に登録される' do
        expect(page).to have_selector '.notice', text: 'The group has been created!'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:group_name) { '' }

      it 'エラーとなる' do
        within ".error" do
          expect(page).to have_content "Nameを入力してください"
        end
      end
    end
  end

  describe '編集機能' do
    let(:login_user) { user_a }

    before do
      visit groups_path
      visit edit_group_path(group_a)
      fill_in 'group[name]', with: group_name
      click_button 'commit'
    end

    context '編集画面で名称を入力した時' do
      let(:group_name) { 'テストを編集する' }
      it '正常に編集される' do
        expect(page).to have_selector '.notice', text: 'The group has been updated!'
      end
    end

    context '編集画面で名称を入力しなかった時' do
      let(:group_name) { '' }
      it 'エラーとなる' do
        within ".error" do
          expect(page).to have_content "Nameを入力してください"
        end
      end
    end
  end


  describe '削除機能' do
    let(:login_user) { user_a }

    before do
      visit groups_path
      first(".delete").click
      click_on 'Delete'

    end

    context 'deleteボタンをクリックした時' do
      it '正常に登録される' do
        expect(page).to have_content 'The group has been deleted!'
      end
    end
  end
end
