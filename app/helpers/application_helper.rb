module ApplicationHelper
  # 0.5刻みで切り上げる。レビューの平均を表示するのに使用。
  # 2倍→切り上げ→2で割る で表現。
  def round_up_by_half(rate)
    (rate * 2).ceil.to_f / 2
  end
end
