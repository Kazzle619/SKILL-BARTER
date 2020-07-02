require 'rails_helper'

RSpec.describe "Signup", type: :system do
  describe '新規会員登録' do
    before do
      visit new_user_registration_path
      fill_in "user[name]", with: '山田 太郎'
      fill_in "user[kana_name]", with: 'ヤマダ タロウ'
      fill_in "user[email]", with: 'example@example.com'
      fill_in "user[phone_number]", with: '09012345678'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'
    end

    context '氏名が空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[name]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content '有効な氏名を入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context 'フリガナが空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[kana_name]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content '有効なフリガナを入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context 'Eメールが空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[email]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content '有効なEメールアドレスを入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context '携帯電話番号が空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[phone_number]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content '有効な電話番号を入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context 'パスワードが空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[password]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content 'パスワードを入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context 'パスワード確認用が空欄の場合' do
      it '新規登録に失敗する。' do
        expect do
          fill_in "user[password_confirmation]", with: ''
          click_on '新規会員登録'
          expect(page).to have_content '上記のパスワードを再度入力してください。'
        end.to change(User, :count).by(0)
      end
    end

    context '全ての欄を適切に埋めた場合' do
      it '新規登録に成功する' do
        expect do
          click_on '新規会員登録'
          expect(page).to have_content 'アカウント登録が完了しました。'
        end.to change(User, :count).by(1)
      end
    end
  end

  describe 'リンクの確認' do
    context '「ログインはこちら」ボタンを押した場合' do
      it 'ログインページへ移動する。' do
        visit new_user_registration_path
        click_on 'ログインはこちら'
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
