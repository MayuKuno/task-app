require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory of user" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  describe 'Presence' do
    context 'when all are present' do
      it "is valid with a nickname、email、password and password_confirmation" do
        user = build(:user)
        expect(user).to be_valid
      end
    end
    context 'when something is missing' do
      it "is invalid without a username" do
        user = build(:user, username: "")
        user.valid?
        expect(user.errors[:username]).to include("を入力してください")
      end

      it "is invalid without an email" do
        user = build(:user, email:"")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it "is invalid without a password" do
        user = build(:user, password:"")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "is invalid without a password_confirmation" do
        user = build(:user, password_confirmation:"")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end
    end
  end

  describe 'Uniqueness' do
    it "is invalid with a duplicate email address" do
      user = create(:user, email: 'testuser@example.com')
      another_user = build(:user, email: 'testuser@example.com')
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "is invalid with a duplicate username" do
      user = create(:user, username: 'testuser')
      another_user = build(:user, username: 'testuser')
      another_user.valid?
      expect(another_user.errors[:username]).to include("はすでに存在します")
    end
  end


  describe 'Format' do
    context 'when input are valid' do
      it "is valid with a valid email address" do
        user = build(:user)
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
      it "confirm if email is saved in lowercase" do
        user = create(:user, email: "Test@examplE.coM")
        expect(user.reload.email).to eq 'test@example.com'
      end  

      it "is valid with a valid username" do
        user = build(:user)
        valid_usernames = %w[testuser mayu Ken]
        valid_usernames.each do |valid_username|
          user.username = valid_username
          expect(user).to be_valid
        end
      end
    end

    context 'when input are invalid' do
      it "is invalid with a invalid email address" do
        user = build(:user)
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com]
          invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
      it "is invalid with a invalid username" do
        user = build(:user)
        invalid_usernames = %w[テストユーザー zenkaku１３ あaいbうc]
        invalid_usernames.each do |invalid_username|
          user.username = invalid_username
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe 'Length' do
    context 'when input are valid' do
      it "is valid with username with 10 words" do
        user = build(:user, username: 'testtestda')
        expect(user).to be_valid
      end
    end

    context 'when input are invalid' do
      it "is invalid with username more than 10 words" do
        user = build(:user, username: 'testtestdes1')
        expect(user).not_to be_valid
      end
    end
  end
end
