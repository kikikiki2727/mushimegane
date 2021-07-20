require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { create :user }
  let(:bug) { create :bug }
  let!(:radar_chart) { create :radar_chart }

  describe 'ログイン前' do
    context 'コメントを投稿する' do
      it 'ログイン画面にリダイレクトされる' do
        visit bug_path(bug)
        fill_in 'comment[sentence]', with: 'コメントします'
        click_on 'コメントを投稿する'
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    before do
      login user
    end

    context 'コメントを投稿する' do
      it '投稿に成功する' do
        visit bug_path(bug)
        fill_in 'comment[sentence]', with: 'コメントします'
        click_on 'コメントを投稿する'
        expect(page).not_to have_content 'コメントがありません'
        expect(page).to have_content 'コメントします'
        expect(page).to have_css '#delete_button'
        expect(current_path).to eq bug_path(bug)
      end
    end

    context '空欄でコメントを投稿する' do
      it '投稿に失敗する' do
        visit bug_path(bug)
        click_on 'コメントを投稿する'
        expect(page).to have_content 'コメント内容を入力してください'
        expect(page).to have_content 'コメントがありません'
        expect(page).not_to have_css('#delete_button')
        expect(current_path).to eq bug_path(bug)
      end
    end
  end
end
