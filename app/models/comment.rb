class Comment < ApplicationRecord
  mount_uploader :image_id, ImageUploader

  belongs_to :user
  belongs_to :proposition

  with_options presence: true do
    validates :user_id
    validates :proposition_id
  end

  # validates :content, presence: { scope: :image_id }
  # これだとcontentカラムにのみpresence: trueのバリデーションがかかっている状態になってしまう模様。
  # やむを得ないのでコメントが空欄 かつ 画像を選択していない場合は投稿できないよう、コントローラーのcreateアクション内とビュー側で対応する。
end
