require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    before do
      visit login_path
    end

    context '有効な値を入力する' do
      it 'ログインに成功する' do
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq root_path 
      end
    end

    context 'メールアドレスを空にする' do
      it 'ログインに失敗する' do
        fill_in 'email', with: nil
        fill_in 'password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path 
      end
    end

    context 'パスワードを空にする' do
      it 'ログインに失敗する' do
        fill_in 'email', with: user.email
        fill_in 'password', with: nil
        click_on 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path 
      end
    end
  end

  describe 'ログアウト機能' do
    before do
      login user
    end

    it 'ログアウトに成功する' do
      find('.navbar-toggler').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
      expect(current_path).to eq root_path 
    end
  end
end
