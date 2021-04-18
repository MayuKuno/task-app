require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, username:'UserA', email: 'a@example.com') } #ユーザーAを作成
  let(:user_b) { FactoryBot.create(:user, username:'UserB', email: 'b@example.com') } #ユーザーBを作成
  let!(:task_a){ FactoryBot.create(:task, taskname: '最初のタスク', user: user_a) }
  
  before do #テストデータの準備
    visit login_path #ログイン画面にアクセスする
    fill_in 'session[email]', with: login_user.email #メールアドレスを入力する
    fill_in 'session[password]', with: login_user.password #パスワードを入力する
    click_button 'commit' #「ログインする」ボタンをおす
  end


  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'#ユーザーAが作成したタスクの名称が画面上に表されていないことを確認
      end
    end


  end


  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
      
    end
  end


  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:task_name) { '新規作成のテストを書く' }

    before do
      visit new_task_path
      fill_in 'task[taskname]', with: task_name
      click_button 'commit'
    end

    context '新規作成画面で名称を入力した時' do
      it '正常に登録される' do
        expect(page).to have_selector '.notice', text: 'The task has been saved!'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        expect(page).to have_selector '.alert', text: 'Please try it again'
      end
    end
  end

  describe '編集機能' do
    let(:login_user) { user_a }

    before do
      visit edit_task_path(task_a)
      fill_in 'task[taskname]', with: task_name
      click_button 'commit'
    end

    context '編集画面で名称を入力した時' do
      let(:task_name) { 'テストを編集する' }
      it '正常に編集される' do
        expect(page).to have_selector '.notice', text: 'The task has been updated!'
      end
    end

    context '編集画面で名称を入力しなかった時' do
      let(:task_name) { '' }
      it 'エラーとなる' do
        expect(page).to have_selector '.alert', text: 'Please try it again'

      end
    end
  end


  describe '削除機能' do
    let(:login_user) { user_a }

    before do
      visit tasks_path
      first("#delete").click
    end

    context 'deleteボタンをクリックした時' do
      it '正常に登録される' do
        expect(page).to have_content 'The task has been deleted!'
      end
    end
  end


  # describe "完了ボタン機能", focus: true do
  #   # プロジェクトを持ったユーザーを準備する
  #   let(:login_user) { user_a }

  #   before do
  #     visit tasks_path
  #     first("#delete").click
  #   end
  #   # ユーザーがプロジェクト画面を開き、"complete"ボタンをクリックすると、
  #   visit project_path(project)
  #   click_button "Complete"

  #   # プロジェクトは完了済みとしてマークされる 
  #   expect(project.reload.completed?).to be true
  #   expect(page).to have_content "Congratulations, this project is complete!"
  #   expect(page).to have_content "Completed"
  #   expect(page).to_not have_button "Complete"
  # end
end





