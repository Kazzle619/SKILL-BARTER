require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe 'アソシエーションのテスト' do
    context 'UserPrefectureモデルとの関係' do
      it '1:Nとなっている' do
        expect(Prefecture.reflect_on_association(:user_prefectures).macro).to eq :has_many
      end
    end
  end
end
