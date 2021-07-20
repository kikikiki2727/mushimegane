require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:user) { create(:user) }
  let(:bug) { create(:bug) }
  let!(:radar_chart) { create(:radar_chart) }
  let(:comment) { create(:comment, bug: bug) }

  describe 'ログイン前' do
    it 'いいねを押すとログイン画面にリダイレクトされる' do
      visit bug_path(comment.bug)
      find('.like_button').click
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq login_path
    end
  end

  describe 'ログイン後' do
    before do
      login user
    end

    it 'いいねボタンを押すとカウントされ、再度押すと解除される' do
      visit bug_path(comment.bug)
      find('.like_button').click
      expect(find('.comment')).to have_content 1
      find('.unlike_button').click
      expect(find('.comment')).to have_content 0
    end
  end
end
