require 'rails_helper'

RSpec.describe "Bugs", type: :system do
  let(:user) { create(:user) }
  let(:bug) { create(:bug) }

  describe 'ログイン前' do
    context '一覧ページ' do
      xit '害虫の一覧が表示される' do
        bug_list = create_list(:bug, 3)
        visit bugs_path
        expect(page).to have_content bug_list[0].name
        expect(page).to have_content bug_list[1].name
        expect(page).to have_content bug_list[2].name
        expect(current_path).to eq bugs_path
      end
    end

    context '新規作成ページ' do
      it 'ログイン画面にリダイレクトされる' do
        visit new_bug_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end

    context '詳細ページ' do
      let!(:radar_chart) { create(:radar_chart, bug: bug) }
      let!(:edit_bug) { create(:bug, user: user) }
      before do
        login user
        visit edit_bug_path(edit_bug)
        attach_file 'bug[image]', "#{Rails.root}/spec/fixtures/images/default.png"
        click_on '更新する'
        logout
        visit bug_path(edit_bug)
      end

      it '害虫の詳細が表示される' do
        expect(page).to have_content edit_bug.name
        expect(page).to have_content Bug.human_attribute_name(:feature)
        expect(page).to have_content Bug.human_attribute_name(:approach)
        expect(page).to have_content Bug.human_attribute_name(:prevention)
        expect(page).to have_content Bug.human_attribute_name(:harm)
        expect(page).to have_content Bug.human_attribute_name(:feature)
        expect(current_path).to eq bug_path(edit_bug)
      end
    end

    context '編集ページ' do
      it 'ログイン画面にリダイレクトされる' do
        visit new_bug_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    let!(:radar_chart) { create(:radar_chart, bug: bug) }
    before do
      login user
    end

    context '新規作成ページ' do
      it '有効な値を入れると新規作成に成功する' do
        visit new_bug_path
        fill_in 'bug[name]', with: '害虫の名前'
        fill_in 'bug[feature]', with: '害虫の特徴'
        fill_in 'bug[approach]', with: '害虫の駆除方法'
        fill_in 'bug[prevention]', with: '害虫の予防方法'
        fill_in 'bug[harm]', with: '害虫の実害'
        select '選択してください', from: 'bug[size]'
        select '黒', from: 'bug[color]'
        select '春', from: 'bug[season]'
        attach_file 'bug[image]', "#{Rails.root}/spec/fixtures/images/default.png"
        click_on '登録する'
        expect(page).to have_content '登録しました'
        expect(Bug.count).to eq 2
        expect(current_path).to eq bug_path(Bug.last)
      end

      it '名前を空欄にすると新規作成に失敗する' do
        visit new_bug_path
        click_on '登録する'
        expect(page).to have_content '登録できませんでした'
        expect(page).to have_content '名前を入力してください'
        expect(current_path).to eq bugs_path
      end
    end

    context '編集ページ' do
      let(:edit_bug) { create(:bug, user: user) }

      it '有効な値を入れると更新できる' do
        visit bug_path(edit_bug)
        click_on '編集'
        fill_in 'bug[feature]', with: '特徴を更新します'
        select '冬', from: 'bug[season]'
        click_on '更新する'
        expect(page).to have_content '更新しました'
        expect(current_path).to eq bug_path(edit_bug)
      end

      it '名前を空欄にすると更新に失敗する' do
        visit edit_bug_path(edit_bug)
        fill_in 'bug[name]', with: nil
        click_on '更新する'
        expect(page).to have_content '更新できませんでした'
        expect(page).to have_content '名前を入力してください'
        expect(current_path).to eq bug_path(edit_bug)
      end
    end
  end
end
