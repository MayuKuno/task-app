require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "validation" do
    context "when input are valid" do 
      it "is valid with a name and more than two people in the group" do
        user_a = create(:user, email: 'user_a@example.com')
        user_b = build(:user, email: 'user_b@example.com')
        group = user_a.groups.build(name: "テストグループ", users: [user_a, user_b])
        expect(group).to be_valid
      end
    end
    context "when input are invalid" do 
      it "is invalid without name" do
        user_a = create(:user, email: 'user_a@example.com')
        user_b = build(:user, email: 'user_b@example.com')
        group = user_a.groups.build(name: "", users: [user_a, user_b])
        expect(group).not_to be_valid
      end
     
      it "is invalid when the member is less than two" do
        user_a = create(:user, email: 'user_a@example.com')
        group = user_a.groups.build(name: "テストグループ", users: [user_a])
        expect(group).not_to be_valid
      end
    end

  end
end