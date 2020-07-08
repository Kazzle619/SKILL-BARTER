require 'rails_helper'

RSpec.describe "SkillBartering", type: :system do
  let!(:guest) { guest_proposition.user }
  let!(:chat_opponent) { chat_opponent_proposition.user }
  let!(:guest_proposition) { create(:proposition, :with_guest) }
  let!(:chat_opponent_proposition) { create(:proposition, :with_chat_opponent) }

  before do
    using_session :guest do
      visit new_user_session_path
      fill_in "user[email]", with: guest.email
      fill_in "user[password]", with: guest.password
      within ".actions" do
        click_on "ログイン"
      end
    end
  end

  describe 'スキルの交換' do
    it 'コメントが投稿できる' do
      using_session :guest do
        visit proposition_path(chat_opponent_proposition.id)
        fill_in "comment[content]", with: 'テストコメント'
        click_on '投稿'
        expect(page).to have_content 'テストコメント'
      end
    end
    it 'スキル交換申請を出していない' do
      using_session :guest do
        visit proposition_path(chat_opponent_proposition.id)
        expect(page).not_to have_content 'スキル交換申請中'
      end
    end
    it '既存の案件からスキル交換申請を出せる', js: true do
      using_session :guest do
        visit proposition_path(chat_opponent_proposition.id)
        click_on 'スキル交換申請'
        choose '既存の案件から申請する'
        within ".existing-proposition-#{guest_proposition.id}" do
          click_on '申請'
        end
        expect(page).to have_content 'スキル交換申請中'
      end
    end
  end
end
