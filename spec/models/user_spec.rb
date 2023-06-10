require 'rails_helper'

RSpec.describe User, type: :model do
  context "name を指定しているとき" do
    let(:user) { build(:user) }

    it "ユーザーが作られる" do
      expect(user).to be_valid
      #user = User.new(name: "foo", email: "foo@example.com", password: "foo12")
      #expect(user.valid?).to eq true

    end
  end

  context "name を指定していないとき" do
    let(:user) { build(:user, email: nil, password: nil) }

    it "ユーザー作成に失敗する" do
      expect(user).not_to be_valid
    end
  end

  context "すでに同じ名前の name が存在しているとき" do
    let(:user) { build(:user, password: nil) }

    it "ユーザー作成に失敗する" do
      expect(user).not_to be_valid
    end
  end
end
