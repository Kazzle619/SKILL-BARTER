class Comment < ApplicationRecord
  attachment :image

  belongs_to :user
  belongs_to :proposition

  with_options presence: true do
    validates :user_id
    validates :proposition_id
  end

  # これだと:contentにのみpresence: trueのバリデーションがかかっている状態になってしまう模様。
  # やむを得ないのでコメントが空欄 かつ 画像を選択していない場合は投稿できないよう、ビュー側で対応する。
  # validates :content, presence: { scope: :image_id }
end
