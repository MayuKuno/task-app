require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it "nickname、email、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "usernameがない場合は登録できないこと" do
      user = build(:user, username: "")
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email:"")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password:"")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation:"")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

  end
end
