require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:bug) { create :bug }
  let!(:radar_chart) { create :radar_chart, bug: bug }

  describe 'コメント投稿機能' do
    context 'コメントを投稿する' do
      it '投稿に成功する' do
        visit bug_path(bug)
        fill_in 'comment[sentence]', with: 'コメントします'
        click_on 'コメントを投稿する'
        expect(page).not_to have_content 'コメントがありません'
        expect(page).to have_content 'コメントします'
        expect(page).to have_css '#comment_delete_button'
        expect(current_path).to eq bug_path(bug)
      end
    end

    context '空欄でコメントを投稿する' do
      it '投稿に失敗する' do
        visit bug_path(bug)
        click_on 'コメントを投稿する'
        expect(page).to have_content 'コメント内容を入力してください'
        expect(page).to have_content 'コメントがありません'
        expect(page).not_to have_css '#comment_delete_button'
        expect(current_path).to eq bug_path(bug)
      end
    end
  end

  describe 'コメント削除機能' do
    context '自分のコメント' do
      before do
        visit bug_path(bug)
        fill_in 'comment[sentence]', with: 'コメントします'
        click_on 'コメントを投稿する'
      end

      it '削除に成功する' do
        expect(page).to have_content 'コメントします'
        expect(page).to have_css '#comment_delete_button'
        page.accept_confirm do
          find('#comment_delete_button').click
        end
        expect(page).not_to have_content 'コメントします'
        expect(page).to have_content 'コメントがありません'
        expect(page).not_to have_css '#comment_delete_button'
        expect(current_path).to eq bug_path(bug)
      end
    end

    context '他人のコメント' do
      let!(:comment) { create(:comment, bug: bug) }

      it '削除ボタンが表示されない' do
        visit bug_path(bug)
        expect(page).not_to have_content 'コメントがありません'
        expect(page).to have_content 'コメントしました'
        expect(page).not_to have_css '#comment_delete_button'
        expect(current_path).to eq bug_path(bug)
      end
    end
  end
end
