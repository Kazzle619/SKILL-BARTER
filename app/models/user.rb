class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :user_prefectures, dependent: :destroy
  has_many :background_schools, dependent: :destroy
  has_many :background_jobs, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :blocks, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews
  has_many :achievements, dependent: :destroy
  has_many :skill_categories, dependent: :destroy

  enum user_status: {
    # 利用中
    subscribing: 1,
    # 退会済
    unsubscribed: 2,
  }

  with_options presence: true do
    validates :name
    validates :kana_name
    validates :user_status

    with_options uniqueness: true do
      validates :phone_number, format: { with: /\A\d{10,11}\z/ }
      validates :email
    end
  end
end
