require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    let(:user) { build(:user) }
    let(:test_user) { user }

    context '全ての項目にデータが入っている' do
      it '保存できる' do
        is_expected.to eq true
      end
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        test_user.name = ""
        is_expected.to eq false
      end
      it '途中にスペースが含まれていること' do
        test_user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
    end

    context 'kana_nameカラム' do
      it '空欄でないこと' do
        test_user.kana_name = ""
        is_expected.to eq false
      end
      it '途中にスペースが含まれていること' do
        test_user.kana_name = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
    end

    context 'birthdayカラム' do
      it '空欄でも良い' do
        test_user.birthday = ""
        is_expected.to eq true
      end
    end

    context 'phone_numberカラム' do
      # 重複のテストをするために、先に指定した電話番号のデータを保存しておく。
      let!(:another_user) { create(:user, phone_number: "09012345678") }

      it '空欄でないこと' do
        test_user.phone_number = ""
        is_expected.to eq false
      end
      it '数字であること' do
        test_user.phone_number = "〇九〇一二三四五六七八"
        is_expected.to eq false
      end
      it 'ハイフンが入っていないこと' do
        test_user.phone_number = "090-1234-5678"
        is_expected.to eq false
      end
      # 以下2つは10,11桁のみということをテストするための内容
      it '9桁未満でないこと' do
        test_user.phone_number = "1" * 9
        is_expected.to eq false
      end
      it '12桁以上でないこと' do
        test_user.phone_number = "1" * 12
        is_expected.to eq false
      end
      it 'DBに重複がないこと' do
        # 既に保存してあるデータの電話番号に変更
        test_user.phone_number = "09012345678"
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '空欄でも可' do
        test_user.introduction = ""
        is_expected.to eq true
      end
    end

    context 'profile_image_idカラム' do
      it '空欄でも可' do
        test_user.profile_image_id = ""
        is_expected.to eq true
      end
    end

    context 'user_statusカラム' do
      it '空欄でないこと(デフォルト値が入る)' do
        test_user.user_status = ""
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      # 重複のテストをするために、先に指定したEメールアドレスのデータを保存しておく。
      let!(:another_user) { create(:user, email: "example0@example.com") }

      it '空欄でないこと' do
        test_user.email = ""
        is_expected.to eq false
      end
      it 'DBに重複がないこと' do
        # 既に保存してあるデータのEメールアドレスに変更
        test_user.email = "example0@example.com"
        is_expected.to eq false
      end
    end

    context 'passwordカラム' do
      it '空欄でないこと' do
        test_user.password = ""
        is_expected.to eq false
      end
    end

    context 'password_confirmationカラム' do
      it '空欄でないこと' do
        test_user.password_confirmation = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'BackgroundSchoolモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:background_schools).macro).to eq :has_many
      end
    end

    context 'BackgroundJobsモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:background_jobs).macro).to eq :has_many
      end
    end

    context 'Propositionモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:propositions).macro).to eq :has_many
      end
    end

    context 'Reviewedモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:revieweds).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end

    context 'Achievementモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:achievements).macro).to eq :has_many
      end
    end

    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end

    context 'UserPrefectureモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_prefectures).macro).to eq :has_many
      end
    end

    context 'dealable_prefectureモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:dealable_prefectures).macro).to eq :has_many
      end
    end

    context 'SkillCategoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:skill_categories).macro).to eq :has_many
      end
    end

    context 'SkillCategoryTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:skill_category_tags).macro).to eq :has_many
      end
    end

    context 'FollowingRelationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:following_relationship).macro).to eq :has_many
      end
    end

    context 'FollowedRelationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followed_relationship).macro).to eq :has_many
      end
    end

    context 'Followingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:following).macro).to eq :has_many
      end
    end

    context 'Followersモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end

    context 'BlockingRelationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:blocking_relationship).macro).to eq :has_many
      end
    end

    context 'BlockedRelationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:blocked_relationship).macro).to eq :has_many
      end
    end

    context 'Blockingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:blocking).macro).to eq :has_many
      end
    end

    context 'Blockersモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:blockers).macro).to eq :has_many
      end
    end
  end
end
