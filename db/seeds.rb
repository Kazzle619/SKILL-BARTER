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
    name: tags[n - 1]
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
    profile_image_id: File.open("./app/assets/images/user_#{gender}_#{rand(1..2)}.jpeg"),
    user_status: 1,
    email: "example#{n + 1}@gmail.com",
    password: "password",
    password_confirmation: "password",
  )
end

# skill_categories
20.times do |n|
  # 1人につき2つskill categoryを用意。
  skill_category_tag = tags.sample(2)
  2.times do |i|
    SkillCategory.create!(
      user_id: n + 1,
      tag_id: Tag.find_by(name: skill_category_tag[i - 1]).id
    )
  end
end

# propositions
# proposition_categories
# request_categories
40.times do |n|
  # 1人につき2つずつ案件を用意。
  # n+1を20で割った余りをidにしてuserを探すが、20は余りが0になってしまうため個別に対応。
  user = User.find((n+ 1) % 20 == 0 ? 20 : (n+ 1) % 20)

  proposition = Proposition.create!(
    user_id: user.id,
    # 要リファクタリング
    title: user.skill_categories.sample.tag.name,
    introduction: "説明です。説明です。説明です。説明です。説明です。",
    deadline: Faker::Date.forward(days: 60),
    barter_status: 1,
    rendering_image_id: File.open("./app/assets/images/proposition_image.jpeg"),
  )

  # 案件のタイトルに使ったタグをそのままproposition_category_tagに使用
  # 対応するTagのidを取ってくる。
  tag_id = Tag.find_by(name: proposition.title).id

  PropositionCategory.create!(
    proposition_id: proposition.id,
    tag_id: tag_id,
  )

  # request_categoryは上記のtag_idの次のものにする。
  # idが10の時は次のものが無いのでidを1にする。
  if tag_id = 10
    request_category_tag_id = 1
  else
    request_category_tag_id = tag_id + 1
  end

  RequestCategory.create!(
    proposition_id: proposition.id,
    tag_id: request_category_tag_id,
  )
end
