# Fakerを日本語設定に
Faker::Config.locale = :ja

# Fakerにはヨミガナはないので、氏名はここから使用。
# 姓、名の漢字とヨミガナの順序はそれぞれ一致している。
last_names =  ["佐藤", "鈴木", "高橋", "田中", "伊藤", "山本", "渡辺", "中村", "小林", "加藤", "吉田", "山田", "佐々木", "山口", "松本", "井上", "木村", "林", "斎藤", "清水", "山崎", "阿部", "森", "池田", "橋本", "山下", "石川", "中島", "前田", "藤田", "後藤", "小川", "岡田", "村上", "長谷川", "近藤", "石井", "斉藤", "坂本", "遠藤", "藤井", "青木", "福田", "三浦", "西村", "藤原", "太田", "松田", "原田", "岡本", "中野", "中川", "小野", "田村", "竹内", "金子", "中山", "和田", "石田", "工藤", "上田", "原", "森田", "酒井", "横山", "柴田", "宮崎", "宮本", "内田", "高木", "谷口", "安藤", "丸山", "今井", "大野", "高田", "菅原", "河野", "武田", "藤本", "上野", "杉山", "千葉", "村田", "増田", "小島", "小山", "大塚", "平野", "久保", "渡部", "松井", "菊地", "岩崎", "松尾", "佐野", "木下", "野口", "野村", "新井", "田口"]
first_names =  ["翔太", "蓮", "翔", "陸", "颯太", "悠斗", "大翔", "翼", "樹", "奏太", "大和", "大輝", "悠", "隼人", "健太", "大輔", "駿", "陽斗", "優", "陽", "悠人", "誠", "拓海", "仁", "悠太", "悠真", "大地", "健", "遼", "大樹", "諒", "響", "太一", "一郎", "優斗", "亮", "海斗", "颯", "亮太", "匠", "陽太", "航", "瑛太", "直樹", "空", "光", "太郎", "輝", "一輝", "蒼", "葵", "優那", "優奈", "凛", "陽菜", "愛", "結衣", "美咲", "楓", "さくら", "遥", "美優", "莉子", "七海", "美月", "結菜", "真央", "花音", "陽子", "舞", "美羽", "優衣", "未来", "彩", "彩乃", "彩花", "優", "智子", "奈々", "千尋", "愛美", "優菜", "杏", "裕子", "芽衣", "綾乃", "琴音", "桜", "恵", "杏奈", "美桜", "優花", "玲奈", "結", "茜", "美穂", "明日香", "愛子", "美緒", "碧"]
kana_last_names =  ["サトウ", "スズキ", "タカハシ", "タナカ", "イトウ", "ヤマモト", "ワタナベ", "ナカムラ", "コバヤシ", "カトウ", "ヨシダ", "ヤマダ", "ササキ", "ヤマグチ", "マツモト", "イノウエ", "キムラ", "ハヤシ", "サイトウ", "シミズ", "ヤマザキ", "アベ", "モリ", "イケダ", "ハシモト", "ヤマシタ", "イシカワ", "ナカジマ", "マエダ", "フジタ", "ゴトウ", "オガワ", "オカダ", "ムラカミ", "ハセガワ", "コンドウ", "イシイ", "サイトウ", "サカモト", "エンドウ", "フジイ", "アオキ", "フクダ", "ミウラ", "ニシムラ", "フジワラ", "オオタ", "マツダ", "ハラダ", "オカモト", "ナカノ", "ナカガワ", "オノ", "タムラ", "タケウチ", "カネコ", "ナカヤマ", "ワダ", "イシダ", "クドウ", "ウエダ", "ハラ", "モリタ", "サカイ", "ヨコヤマ", "シバタ", "ミヤザキ", "ミヤモト", "ウチダ", "タカギ", "タニグチ", "アンドウ", "マルヤマ", "イマイ", "オオノ", "タカダ", "スガワラ", "コウノ", "タケダ", "フジモト", "ウエノ", "スギヤマ", "チバ", "ムラタ", "マスダ", "コジマ", "コヤマ", "オオツカ", "ヒラノ", "クボ", "ワタナベ", "マツイ", "キクチ", "イワサキ", "マツオ", "サノ", "キノシタ", "ノグチ", "ノムラ", "アライ", "タグチ"]
kana_first_names =  ["ショウタ", "レン", "ショウ", "リク", "ソウタ", "ユウト", "ヒロト", "ツバサ", "イツキ", "ソウタ", "ヤマト", "ダイキ", "ユウ", "ハヤト", "ケンタ", "ダイスケ", "シュン", "ハルト", "ユウ", "ヨウ", "ユウト", "マコト", "タクミ", "ジン", "ユウタ", "ユウマ", "ダイチ", "タケル", "リョウ", "ダイキ", "リョウ", "ヒビキ", "タイチ", "イチロウ", "ユウト", "リョウ", "カイト", "カエデ", "リョウタ", "タクミ", "ヨウタ", "ワタル", "エイタ", "ナオキ", "ソラ", "ヒカリ", "タロウ", "アキラ", "カズキ", "アオイ", "アオイ", "ユウナ", "ユウナ", "リン", "ハルナ", "アイ", "ユイ", "ミサキ", "カエデ", "サクラ", "ハルカ", "ミユウ", "リコ", "ナナミ", "ミヅキ", "ユナ", "マオ", "カノン", "ヨウコ", "マイ", "ミウ", "ユイ", "ミク", "アヤ", "アヤノ", "アヤカ", "ユウ", "トモコ", "ナナ", "チヒロ", "マナミ", "ユウナ", "アン", "ユウコ", "メイ", "アヤノ", "コトネ", "サクラ", "メグミ", "アンナ", "ミウ", "ユウカ", "レナ", "ユイ", "アカネ", "ミホ", "アスカ", "アイコ", "ミオ", "ミドリ"]


# tags
tags = ["Webアプリ作成", "Webデザイン", "コーチング", "Webサイト作成", "スマホアプリ作成", "学習指導", "電子工作", "CGデザイン", "グラフィックデザイン", "楽曲作成", ]

(tags.length).times do |n|
  Tag.create!(
    name: tags[n]
  )
end

# users
20.times do |n|
  # 姓、名を何番目から取ってくるのかランダムに設定
  first_name_random = rand(first_names.length)
  last_name_random = rand(last_names.length)

  # 適切なサンプル画像をマッチするために設定
  # first_name_randomが48以下なら男性
  if first_name_random <= 48
    gender = "male"
  else
    gender = "female"
  end

  # 上記randomを使用して姓、名をそれぞれ取得
  first_name = first_names[first_name_random]
  last_name = last_names[last_name_random]
  kana_first_name = kana_first_names[first_name_random]
  kana_last_name = kana_last_names[last_name_random]

  User.create!(
    name: "#{last_name}　#{first_name}",
    kana_name: "#{kana_last_name}　#{kana_first_name}",
    birthday: Faker::Date.birthday(min_age: 18, max_age: 40),
    phone_number: Faker::PhoneNumber.cell_phone.delete("-"),
    introduction: "自己紹介です。自己紹介です。自己紹介です。自己紹介です。自己紹介です。",
    profile_image: File.open("./app/assets/images/user_#{gender}_#{rand(1..2)}.jpeg"),
    user_status: 1,
    email: "example#{n + 1}@gmail.com",
    password: "password",
    password_confirmation: "password",
  )
end

# skill_categories
User.all.each do |user|
  # 1人につき5つskill categoryを用意。
  skill_category_tags = Tag.all.sample(5)
  5.times do |i|
    SkillCategory.create!(
      user_id: user.id,
      tag_id: skill_category_tags[i].id
    )
  end
end

# prefectures
# 47都道府県 + 全国なので計48個
48.times do |n|
  Prefecture.create!(
    # 都道府県名はenumで設定してある。
    name: n + 1,
  )
end

# user_prefectures
User.all.each do |user|
  UserPrefecture.create!(
    user_id: user.id,
    prefecture_id: rand(1..48),
  )
end

# achievements
# achievement_categories
20.times do |n|
  user = User.find(n + 1)

  # 1人につき5つずつ実績を用意。
  5.times do |i|
    achievement = Achievement.create!(
      user_id: user.id,
      # 要リファクタリング
      title: "#{user.skill_categories.sample.tag.name}の実績",
      introduction: "説明です。" * rand(5..10),
    )

    # 実績のタイトルに使ったタグをそのままachievement_category_tagに使用
    # 対応するTagのidを取ってくる。
    tag_id = Tag.find_by(name: achievement.title.delete_suffix("の実績")).id

    AchievementCategory.create!(
      achievement_id: achievement.id,
      tag_id: tag_id,
    )
  end
end

# background_schools
User.all.each do |user|
  # 高校は全員卒業
  BackgroundSchool.create!(
    user_id: user.id,
    school_name: Faker::University.name.gsub("大学", "高校"),
    school_type: 1,
    enrollment_status: 1,
  )

  # 専門学校〜大学はランダムに選び、在籍ステータスもランダム
  school_type = rand(2..5)
  school_type_name = { "専門学校" => 2, "短大" => 3, "大学" => 4, "大学校" => 5 }.key(school_type)
  bs = BackgroundSchool.create!(
    user_id: user.id,
    school_name: Faker::University.name.gsub("大学", school_type_name),
    school_type: school_type,
    enrollment_status: rand(1..3),
  )
  # 大学の場合は学部を追加。大学の専門が不明なため全員教養学部。
  if bs.university?
    bs.update!(department: "教養学部")
  end
end

# background_jobs
User.all.each do |user|
  bg = BackgroundJob.create!(
    user_id: user.id,
    company_name: Faker::Company.name,
    department: ["総務部", "営業部", "広報部", "人事部", "情報システム部"].sample,
    position: ["主任", "係長", "課長", "次長", "部長", "本部長", "社長"].sample,
    joining_date: Faker::Date.between(from: 5.years.ago, to: 3.years.ago),
    retirement_date: [Faker::Date.between(from: 3.years.ago, to: 1.years.ago)][rand(0..1)],
  )
  # もし退職日が有る(=退職している)場合は現在の仕事を作る。
  if bg.retirement_date.present?
    BackgroundJob.create!(
      user_id: user.id,
      company_name: Faker::Company.name,
      department: ["総務部", "営業部", "広報部", "人事部", "情報システム部"].sample,
      position: ["主任", "係長", "課長", "次長", "部長", "本部長", "社長"].sample,
      joining_date: bg.retirement_date + 1,
    )
  end
end

# propositions
# proposition_categories
# request_categories
User.all.each do |user|
  # 1人につき5つずつ案件を用意。
  5.times do |i|
    proposition = Proposition.create!(
      user_id: user.id,
      # 要リファクタリング
      title: "#{user.skill_categories.sample.tag.name}の案件",
      introduction: "説明です。" * rand(5..10),
      deadline: Faker::Date.forward(days: 60),
      barter_status: 1,
      rendering_image: File.open("./app/assets/images/proposition_image.jpeg"),
    )

    # 案件のタイトルに使ったタグをそのままproposition_category_tagに使用
    # 対応するTagのidを取ってくる。
    tag_id = Tag.find_by(name: proposition.title.delete_suffix("の案件")).id

    PropositionCategory.create!(
      proposition_id: proposition.id,
      tag_id: tag_id,
    )

    # request_categoryは上記のtag_idを11から引いたものにする。
    request_category_tag_id = 11 - tag_id

    RequestCategory.create!(
      proposition_id: proposition.id,
      tag_id: request_category_tag_id,
    )
  end
end

# comments
100.times do |n|
  rand(3..5).times do |i|
    Comment.create!(
      user_id: rand(1..20),
      proposition_id: n + 1,
      content: "コメントです。" * rand(5..10),
    )
  end
end

# offers
# requests
# 要リファクタリング
User.first(10).each do |user|
  # 100個の案件を逆に数えて行ったものが基本的な相手
  # 1つめは相互レビュー状態に
  passive_proposition_id_1 = 101 - user.propositions[0].id
  Review.create!(
    user_id: user.id,
    proposition_id: passive_proposition_id_1,
    comment: "レビューです。" * rand(5..10),
  )
  Review.create!(
    user_id: Proposition.find(passive_proposition_id_1).user.id,
    proposition_id: user.propositions[0].id,
    comment: "レビューです。" * rand(5..10),
  )
  Offer.create!(
    offering_id: user.propositions[0].id,
    offered_id: passive_proposition_id_1,
  )
  Offer.create!(
    offering_id: passive_proposition_id_1,
    offered_id: user.propositions[0].id,
  )

  # 2つ目は自分だけレビューしている状態に
  passive_proposition_id_2 = 101 - user.propositions[1].id
  Review.create!(
    user_id: user.id,
    proposition_id: passive_proposition_id_2,
    comment: "レビューです。" * rand(5..10),
  )
  Offer.create!(
    offering_id: user.propositions[1].id,
    offered_id: passive_proposition_id_2,
  )
  Offer.create!(
    offering_id: passive_proposition_id_2,
    offered_id: user.propositions[1].id,
  )

  # 3つ目は残った中からランダムに申請だけ
  passive_proposition_id_3 = 101 - user.propositions[2].id - rand(0..2)
  Offer.create!(
    offering_id: user.propositions[2].id,
    offered_id: passive_proposition_id_3,
  )

  # idが3の案件に対する申請を少し多めに
  if user.id == 2 || user.id == 3 || user.id == 4
    Offer.create!(
      offering_id: user.propositions[3].id,
      offered_id: 3,
    )
  end
end

# できたreviews, offersの状況に併せて案件の交換ステータスを更新。
Proposition.all.each do |proposition|
  proposition.auto_update_barter_status
end
