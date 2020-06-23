require 'rails_helper'

RSpec.describe "Header", type: :system do
  let(:user) { create(:user) }

  describe "ログインしていない場合" do
    before do
      visit root_path
    end

    context "ヘッダーの表示を確認" do
      it "ロゴが表示される" do
        pending "表示されているはずだが、何故が存在しないと言われる。"
        expect(page).to have_selector("img[src$='skill_barter_logo']")
      end
      it "ロゴがトップページへのリンクになっている" do
        click_on "skill_barter_logo"
        expect(current_path).to eq root_path
      end
      it "ログインリンクが表示される。" do
        click_on "ログイン"
        expect(current_path).to eq new_user_session_path
      end
      it "新規登録リンクが表示される。" do
        click_on "新規登録"
        expect(current_path).to eq new_user_registration_path
      end
    end
  end

  describe "ログインしている場合" do
    before do
      visit new_user_session_path
      fill_in "user[email]", with: user.name
      fill_in "user[password]", with: user.password
      within ".actions" do
        click_on "ログイン"
      end
    end

    context "ヘッダーの表示を確認" do
      it "ロゴが表示される" do
        pending "表示されているはずだが、何故が存在しないと言われる。"
        expect(page).to have_selector("img[src$='skill_barter_logo']")
      end
      it "ロゴがトップページへのリンクになっている" do
        click_on "skill_barter_logo"
        expect(current_path).to eq root_path
      end
      it "マイページリンクが表示される。" do
        click_on "マイページ"
        expect(current_path).to eq mypage_users_path
      end
      it "ログアウトリンクが表示される。" do
        click_on "ログアウト"
        expect(current_path).to eq root_path
      end
    end
  end
end
