require 'rails_helper'

RSpec.describe BackgroundJob, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_background_job.valid? }

    let(:test_background_job) { build(:background_job) }
    let(:user) { create(:user) }

    before do
      test_background_job.user_id = user.id
    end

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        test_background_job.user_id = ""
        is_expected.to eq false
      end
    end

    context 'company_nameカラム' do
      it '空欄でないこと' do
        test_background_job.company_name = ""
        is_expected.to eq false
      end
    end

    context 'departmentカラム' do
      it '空欄でも良い' do
        test_background_job.department = ""
        is_expected.to eq true
      end
    end

    context 'positionカラム' do
      it '空欄でも良い' do
        test_background_job.position = ""
        is_expected.to eq true
      end
    end

    context 'joining_dateカラム' do
      it '空欄でないこと' do
        test_background_job.joining_date = ""
        is_expected.to eq false
      end
    end

    context 'retirement_dateカラム' do
      it '空欄でも良い' do
        test_background_job.retirement_date = ""
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(BackgroundJob.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
