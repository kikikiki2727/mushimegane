require 'rails_helper'

RSpec.describe "Users", type: :system do

  before do
    visit new_user_path
  end

  describe 'ログイン前' do
    describe 'ユーザー新規作成' do
      context '有効な値を入れる' do
        it 'ユーザー登録が成功する' do
          fill_in 'user[name]', with: '田中太郎'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_on '登録'
          expect(page).to have_content '登録が完了しました'
          expect(current_path).to eq login_path
        end
      end

      context '名前を空にする' do
        it 'ユーザー登録に失敗する' do
          fill_in 'user[name]', with: nil
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_on '登録'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq users_path
        end
      end

      context 'メールアドレスを空にする' do
        it 'ユーザー登録に失敗する' do
          fill_in 'user[name]', with: '田中太郎'
          fill_in 'user[email]', with: nil
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_on '登録'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq users_path
        end
      end

      context '重複したメールアドレスを入力する' do
        let(:user) { create(:user) }

        it 'ユーザー登録に失敗する' do
          fill_in 'user[name]', with: '田中太郎'
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_on '登録'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq users_path
        end
      end

      context 'パスワードを空にする' do
        it 'ユーザー登録に失敗する' do
          fill_in 'user[name]', with: '田中太郎'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: nil
          fill_in 'user[password_confirmation]', with: nil
          click_on '登録'
          expect(page).to have_content 'パスワードは8文字以上で入力してください'
          expect(page).to have_content 'パスワード(確認)を入力してください'
          expect(current_path).to eq users_path
        end
      end
    end
  end
end
