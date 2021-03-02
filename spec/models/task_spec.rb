require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Taskモデルのテスト" do
    user = FactoryBot.create(:user)
    
    context "バリデーションのテスト" do 
      it "tasknameがない場合は登録できないこと" do
        task = user.tasks.build(taskname: "",description: "テスト内容")
        expect(task).not_to be_valid
      end
     
      it "tasknameが存在すれば登録できること" do
        task = user.tasks.build(taskname: "テストタイトル",description: "")
        expect(task).to be_valid
      end
    end
  end
end