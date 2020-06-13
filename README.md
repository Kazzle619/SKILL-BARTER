# SKILL-BARTER

登録者同士でスキルを物々交換できるアプリです。<br>
インフラにAWSの各種サービスを活用しています。

<img width="45%" alt="top_page" src="https://user-images.githubusercontent.com/55101031/84561517-1b18f780-ad88-11ea-8bd4-1c6aa06c65a4.png"> <img width="45%" alt="proposition_detail" src="https://user-images.githubusercontent.com/55101031/84561521-1e13e800-ad88-11ea-8208-c008de6ca07f.png">

## テーマを選んだ理由
**1. 自分自身の経験から金銭を介さずスキルを借りられる場が欲しかった。**

  他人のスキルを借りたい(デザイン、コーチングなど)と思うことがあったが、調べて見ると思ったよりも値が張った。そんな時、金銭を介さず今の自分のスキルと他人のスキルを物々交換できると良いのでは、と思っていた。

**2. 若者が自己効力感を高める場の提供**

  前職で高校生を指導し、大学生とともに働く中で、社会に出るまでは自分の知識・スキルが他人の役に立つ、という実感を得る場面が中々少ないと感じていた。ただ、大学・高校生には金銭のやり取りが発生する「取引」はハードルが高いかも知れない。自分のスキルをよりライトに他人に役立てる場があると、自己効力感を高めることに貢献できるのではないかと考えた。

## 使用技術
- Ruby 2.5.7, Rails 5.2.4.3
- MySQL 5.5.62
- Nginx, Puma
- AWS(EC2, RDS, Route 53, S3)
- Capistrano
- RSpec
- Bootstrap, jQuery

### gem
詳細設計書をご参照ください。

## 機能一覧
- ユーザー関連機能
  - devise使用
  - 新規登録、ログイン、ログアウト
  - マイページ<br>
  (フォロワー、フォロー中、ブロック中、実績一覧)
  - 登録情報編集機能<br>
  (基本情報、スキルカテゴリ、活動都道府県、職歴、学歴)
- 案件関連機能
  - 案件一覧表示、案件詳細表示、マイ案件一覧表示、ストック案件一覧表示、案件新規作成・編集・削除
  - 案件カテゴリ、要望カテゴリの追加・編集・削除
- 実績関連機能
  - 実績新規作成・編集・削除
- チャット機能
  - Action Cableを使用。マッチ中の当事者同士のみ使用可能。閲覧は誰でも可能。
- 検索機能
  - 案件、ユーザーそれぞれ可能
  - 複数の条件を指定可能
- レビューレート機能
  - レビュー時に☆の数で評価可能
  - 評価後の案件には☆でレビューレートが表示される。
  - ユーザー情報にレビューレート平均が表示される。
- 画像投稿
  - ユーザープロフィール、案件完成イメージ、実績、コメントに画像をアップロード可能。carrierwave × S3で実装。
- ストック(イイね)、フォロー機能
  - Ajaxを使用
- ブロック機能
  - ブロックするとフォロー関係を解消し、ブロックしたユーザー詳細、案件詳細は閲覧不可に。
- コメント機能
  - 画像はドラッグアンドドロップで追加可能
- ページネーション
  - kaminariを使用
- テストログイン機能
  - テストユーザーとチャット機能確認用のチャットテストユーザーに、ヘッダーからワンクリックでログイン可能

## 設計

### ER図
![ER図](https://user-images.githubusercontent.com/55101031/84561563-67643780-ad88-11ea-820f-c590ead2e4a3.jpg)
[draw.ioでの確認はこちら](https://drive.google.com/file/d/17JqPEEykcJYkZngWkQBNlMwniXdGkfQN/view?usp=sharing)

### DB設計書
[スプレッドシート](https://docs.google.com/spreadsheets/d/1lgahJzw4uwUWDRDxcONR_153nPLABkCLwe5igpG7_1w/edit?usp=sharing)

### 詳細設計書
[スプレッドシート](https://docs.google.com/spreadsheets/d/1JeHXmIbGIHml-djug-dDGDEXE9GxenEwLWyZIWuSTVs/edit?usp=sharing)

### 機能一覧
[スプレッドシート](https://docs.google.com/spreadsheets/d/1XjbB5lF_9hvFqf1PenRr3yR3Fn6brCduQYDqwlXHT0o/edit#gid=0)
