require 'rails_helper'

RSpec.describe Bug, type: :model do
  let(:bug) { build(:bug) }

  describe 'バリデーション' do
    it '適切な値を入れると有効であること' do
      expect(bug).to be_valid
      expect(bug.errors).to be_empty
    end

    it '名前が空だと無効であること' do
      bug.name = nil
      expect(bug).to be_invalid
      expect(bug.errors[:name]).to include 'を入力してください'
    end
  end
end
