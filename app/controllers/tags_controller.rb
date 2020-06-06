class TagsController < ApplicationController
  # before_action :authenticate_user!

  def create
    @tag = Tag.new(name: tag_params)
    if @tag.save
      # 本当はrenderで値が入ったままにできればなお良し。ただ、formが一層複雑になるのでひとまずredirect。後程変更予定。
      redirect_to request.referer
    else
      # ここも上記と同じく、本当はrenderが良い。ひとまずredirect。後程変更予定。
      redirect_to request.referer
    end
  end

  private

  # フォームを入れ子にしている都合でモデル名(:tag)は飛んできていない。後程変更予定。
  def tag_params
    params.require(:name)
  end

  # 押した「追加」ボタンによって案件カテゴリ、要望カテゴリかを識別し、renderの際に値を入れておきたい。後程変更予定。
  def category_type
    params.to_unsafe_hash.key("追加") + "_type_id"
  end
end
