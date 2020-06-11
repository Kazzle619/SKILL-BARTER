class Proposition < ApplicationRecord
  # proposition#offerの処理判定で、paramsのままだと扱いにくいので属性を追加。
  attr_accessor :proposition_category_tag_id, :request_category_tag_id

  mount_uploader :rendering_image_id, ImageUploader

  belongs_to :user

  # has_many :offers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :proposition_rooms, dependent: :destroy
  has_one  :review, dependent: :destroy

  has_many :proposition_categories, dependent: :destroy
  has_many :proposition_category_tags, through: :proposition_categories, source: :tag

  has_many :request_categories, dependent: :destroy
  has_many :request_category_tags, through: :request_categories, source: :tag

  has_one  :offering_relationship, class_name: "Offer",
                                   foreign_key: "offering_id",
                                   dependent: :destroy
  has_many :offered_relationships, class_name: "Offer",
                                   foreign_key: "offered_id",
                                   dependent: :destroy
  has_one  :offering, through: :offering_relationship, source: :offered
  has_many :offerers, through: :offered_relationships, source: :offering

  enum barter_status: {
    # 未マッチング かつ 未スキル交換申請
    matching: 1,
    # スキル交換申請中
    offering: 2,
    # マッチング済
    matched: 3,
    # 交換完了申請中(自分だけレビューを書いている。)
    bartering: 4,
    # 交換済み(履歴へ)
    bartered: 5,
  }

  with_options presence: true do
    validates :user_id
    validates :title
    validates :introduction
    validates :barter_status
  end

  # 案件(self)に自分(current_user)がスキル交換申請を出しているかを判定する。
  def offering_to?
    # 案件(self)にスキル交換申請を出しているユーザー一覧を取得
    offerer_users = offerers.map(&:user)
    # 上記一覧に自分が入っているかで確認。
    offerer_users.include?(User.current)
  end

  # 案件(self)と自分(current_user)の案件がマッチしているかを判定する。
  def matched_with?
    is_matched? && offering.user == User.current
  end

  # 案件(self)がレビューされているかどうかを判定する。
  def is_reviewed?
    !!review
  end

  # 案件(self)に出している自分の申請(offer)を取得
  def my_offering_proposition
    # スキル交換申請が来ている案件の中で、そのユーザーが自分のものを取得。1つしか無いはず。
    offerers.select { |offerer| offerer.user == User.current }.pop
  end

  # is_○○は○○以上の状況か、を判定している。
  # 例えばis_bertering?は交換完了申請中, 交換完了どちらの状況にもtrueが出る。

  # 案件(self)で申請を出しているかを判定。
  def is_offering?
    offering.present?
  end

  # マッチング済みかどうかを判定。offerしている相手のoffer相手が自分になっているかで確認。
  def is_matched?
    self == offering.offering if offering.present?
  end

  # 交換完了申請中かどうか( 案件(self)のオーナーがレビューを書いている状態か )を判定。
  def is_bartering?
    if offering.present?
      owner_review = Review.find_by(user_id: user.id, proposition_id: offering.id)
    end

    owner_review.present?
  end

  # スキル交換が完了しているか(お互いレビューを書いたか)を判定。
  def is_bartered?
    if offering.present?
      owner_review = Review.find_by(user_id: user.id, proposition_id: offering.id)
      opponent_review = Review.find_by(user_id: offering.user.id, proposition_id: id)
    else
      owner_review = nil
      opponent_review = nil
    end

    owner_review.present? && opponent_review.present?
  end

  # 状況に応じてbarter_statusを自動更新する。
  def auto_update_barter_status
    if is_bartered?
      update(barter_status: "bartered")
    elsif is_bartering?
      update(barter_status: "bartering")
    elsif is_matched?
      update(barter_status: "matched")
    elsif is_offering?
      update(barter_status: "offering")
    # 交換申請を取り下げた場合に該当
    else
      update(barter_status: "matching")
    end
  end

  # 現在のマッチング相手とのRoomを取得
  def room
    this_propositions_room_ids = proposition_rooms.map(&:room_id)
    if is_offering?
      opponent_propositions_room_ids = offering.proposition_rooms.map(&:room_id)
    else
      opponent_propositions_room_ids = []
    end
    # 上記2つの共通IDが目当てのroom_id。あるなら1つしか無いはず。
    room_id = (this_propositions_room_ids & opponent_propositions_room_ids).pop
    if is_matched? && room_id.present?
      Room.find(room_id)
    end
  end
end
