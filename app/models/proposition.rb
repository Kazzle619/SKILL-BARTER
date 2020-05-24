class Proposition < ApplicationRecord
  belongs_to :user

  attachment :rendering_image

  # has_many :offers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :proposition_categories, dependent: :destroy
  has_many :request_categories, dependent: :destroy
  has_many :proposition_rooms, dependent: :destroy
  has_many :chat_messages, dependent: :destroy

  has_many :offering_relationship, class_name: "Offer",
                                   foreign_key: "offering_id",
                                   dependent: :destroy
  has_many :offered_relationship, class_name: "Offer",
                                  foreign_key: "offered_id",
                                  dependent: :destroy
  has_many :offering, through: :offering_relationship, source: :offered
  has_many :offerers, through: :offered_relationship, source: :offering

  enum barter_status: {
    # 未マッチング
    matching: 1,
    # マッチング済
    matched: 2,
    # 交換済み(履歴へ)
    bartered: 3,
  }

  with_options presence: true do
    validates :user_id
    validates :title
    validates :introduction
    validates :barter_status
  end

  # 案件に自分(current_user)が申請を出しているかを判定する。
  def offering?
    # ログインユーザーの案件一覧を取得
    current_user_propositions = User.current.propositions
    # 上記をidに変更。(offering_propositionで使うので@を付与)
    @current_user_proposition_ids = current_user_propositions.map(&:id)

    # 案件に来ているoffer一覧を取得
    offers = Offer.where(offered_id: id)
    # 上記をoffering_idの一覧に(offering_propositionで使うので@を付与)
    @offers_id = offers.map(&:offering_id)

    # current_user_proposition_idsとoffers_idに重複する要素があるか(空集合になっていないか)どうかで判定
    # あればオファーしているということ。
    @current_user_proposition_ids & @offers_id != []
  end

  # 案件に申請を出している自分の案件を取得
  def my_offer
    if offering?
      # 1つしか無いはず。要リファクタリング。
      offering_proposition_id = (@current_user_proposition_ids & @offers_id)[0]
      Offer.find_by(offering_id: offering_proposition_id)
    end
  end

  # 相互offerになっているかを確認
  def matched?
    offering == offered
  end

  # offerの状況に応じてbarter_statusを自動更新する。
  # 相互にoffer: barter_statusをmatchedに。
  # 相互offerになっていない: barter_statusをmatchingに。
  def auto_update_barter_status
    # 相互オファーになっているか
    if matched?
      self.barter_status = "matched"
    else
      self.barter_status = "matching"
    end
  end
end
