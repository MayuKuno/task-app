require 'rails_helper'

RSpec.describe 'Task', type: :system do
  let(:user_a){ FactoryBot.create(:user, username: 'ユーザーA', email: 'a@example.com') }
  let(:user_b){ FactoryBot.create(:user, username: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a){ FactoryBot.create(:task, taskname: 'rubyの勉強をする', user: user_a) }

  let(:user_c){ FactoryBot.create(:user, username: 'ユーザーC', email: 'c@example.com') }
  let!(:task_b){ FactoryBot.create(:task, id: 1, taskname: 'a', created_at: Time.current + 1.days, user: user_c) }
  let!(:task_c){ FactoryBot.create(:task, id: 2, taskname: 'b', created_at: Time.current + 2.days, user: user_c) }
  let!(:task_d){ FactoryBot.create(:task, id: 3, taskname: 'c', created_at: Time.current + 3.days, user: user_c) }



  before do
    FactoryBot.create(:task, user: user_a)
    visit new_user_session_path
    fill_in 'user[email]', with: login_user.email
    fill_in 'user[password]', with: login_user.password
    click_button 'commit'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content 'rubyの勉強をする' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーBが作成したタスクが表示される' do
        expect(page).to have_no_content 'rubyの勉強をする'
      end
    end


    context 'ユーザーCが時差でタスクを複数登録した時' do
      let(:login_user) { user_c }

      it "created_at降順で表示される" do
        visit tasks_path
        task = all('.tasks')
        task_0 = task[0]
        expect(task_0).to have_content "c"
      end 
    end


    # context 'Name of Taskを押した時' do
    #   let(:login_user) { user_c }

    #   before do
    #     visit tasks_path
    #     click_link 'Name of Task'
    #   end

    #   it "taskname降順で表示される" do
    #     task = all('.tasks')
    #     task_0 = task[0]
    #     expect(task_0).to have_content "a"
    #   end 
    # end



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

    before do
      visit new_task_path
      fill_in 'task[taskname]', with: task_name
      click_button 'commit'
    end

    context '新規作成画面で名称を入力した時' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.notice', text: 'The task has been saved!'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        within '.alert' do
          expect(page).to have_content 'Please try it again'
        end
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
      let(:task_name) { '編集のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.notice', text: 'The task has been updated!'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        within '.alert' do
          expect(page).to have_content 'Please try it again'
        end
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



end





