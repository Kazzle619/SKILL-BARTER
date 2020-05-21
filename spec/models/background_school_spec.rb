require 'rails_helper'

RSpec.describe BackgroundSchool, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_background_school.valid? }

    let(:test_background_school) { build(:background_school) }
    let(:user) { create(:user) }

    before do
      test_background_school.user_id = user.id
    end

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_background_school.user_id = ""
        is_expected.to eq false
      end
    end

    context 'school_nameカラム' do
      it '空欄でないこと' do
        test_background_school.school_name = ""
        is_expected.to eq false
      end
    end

    context 'school_typeカラム' do
      it '空欄でないこと' do
        test_background_school.school_type = ""
        is_expected.to eq false
      end
    end

    context 'departmentカラム' do
      it '空欄でも良い' do
        test_background_school.department = ""
        is_expected.to eq true
      end
    end

    context 'enrollment_statusカラム' do
      it '空欄でないこと' do
        test_background_school.enrollment_status = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(BackgroundSchool.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
