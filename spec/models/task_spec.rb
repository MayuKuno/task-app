require 'rails_helper'

RSpec.describe Task, type: :model do
  it "has a valid factory of task" do
    expect(FactoryBot.create(:task)).to be_valid
  end

  before do
    @user = FactoryBot.create(:user)
  end
  
  describe "validation" do 
    context "when input are valid" do
      it "is valid with a taskname" do
        task = @user.tasks.build(taskname: "テストタイトル", description: "")
        expect(task).to be_valid
      end
      it "is valid without a user_id" do
        task = FactoryBot.build(:task)
        expect(task).to be_valid
      end
    end
    context "when input are invalid" do
      it "is invalid without a taskname" do
        task = @user.tasks.build(taskname: "",description: "テスト内容")
        expect(task).not_to be_valid
      end
      it "is invalid without a user_id" do
        task = FactoryBot.build(:task, user: nil)
        expect(task).not_to be_valid
      end
    end
  end

  describe "late status" do
    it "is late when the due date is past today" do
      task = FactoryBot.create(:task, :due_yesterday)
      expect(task).to be_late
    end
    it "is on time when the due date is today" do
      task = FactoryBot.create(:task, :due_today)
      expect(task).to_not be_late
    end
    it "is on time when the due date is in the future" do
      task = FactoryBot.create(:task, :due_tomorrow)
      expect(task).to_not be_late
    end
  end
end