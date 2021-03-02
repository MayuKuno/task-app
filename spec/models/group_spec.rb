require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "Groupモデルのテスト" do

    context "バリデーションのテスト" do 
      it "nameがない場合は登録できないこと" do
        user_a = create(:user, email: 'user_a@example.com')
        user_b = build(:user, email: 'user_b@example.com')

        group = user_a.groups.build(name: "", users: [user_a, user_b])
        expect(group).not_to be_valid
      end
     
      it "nameがあっても二人以上選択されてなければ登録できないこと" do
        user_a = create(:user, email: 'user_a@example.com')
        group = user_a.groups.build(name: "テストグループ", users: [user_a])
        expect(group).not_to be_valid
      end

      it "nameと二人以上選択されていれば登録できること" do
        user_a = create(:user, email: 'user_a@example.com')
        user_b = build(:user, email: 'user_b@example.com')
        group = user_a.groups.build(name: "テストグループ", users: [user_a, user_b])
        expect(group).to be_valid

      end

    end
  end
end