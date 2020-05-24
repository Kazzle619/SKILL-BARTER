class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :user_prefectures, dependent: :destroy
  has_many :background_schools, dependent: :destroy
  has_many :background_jobs, dependent: :destroy
  # has_many :follows, dependent: :destroy
  # has_many :blocks, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews
  has_many :achievements, dependent: :destroy
  has_many :skill_categories, dependent: :destroy

  has_many :following_relationship, class_name: "Follow",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :followed_relationship, class_name: "Follow",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :following_relationship, source: :followed
  has_many :followers, through: :followed_relationship, source: :follower

  has_many :blocking_relationship, class_name: "Block",
                                   foreign_key: "blocker_id",
                                   dependent: :destroy
  has_many :blocked_relationship, class_name: "Block",
                                  foreign_key: "blocked_id",
                                  dependent: :destroy
  has_many :blocking, through: :blocking_relationship, source: :blocked
  has_many :blockers, through: :blocked_relationship, source: :blocker

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

  # モデル内でcurrent_userを取得するために記載
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
