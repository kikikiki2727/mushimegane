require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション' do
    it '属性をすべて入れると有効であること' do
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it '名前が空白だと無効であること' do
      user.name = nil
      expect(user).to be_invalid
    end

    it '名前が31字以上だと無効であること' do
      user.name = 'a' * 31
      expect(user).to be_invalid
    end

    it 'メールアドレスが空白だと無効であること' do
      user.email = nil
      expect(user).to be_invalid
    end

    it 'すでに登録されているメールアドレスだと無効であること' do
      another_user = create(:user)
      user.email = another_user.email
      expect(user).to be_invalid
    end

    it '重複していないメールアドレスだと有効であること' do
      create(:user)
      user.email = 'other@exmple.com'
      expect(user).to be_valid
    end

    it 'パスワードが空白だと無効であること' do
      user.password = ''
      expect(user).to be_invalid
    end

    it 'パスワードが8文字未満だと無効であること' do
      user.password = 'a' * 7
      expect(user).to be_invalid
    end
  end
end
