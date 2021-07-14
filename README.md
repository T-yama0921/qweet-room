# テーブル設計

## usersテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| nickname         | string    | null: false |
| email            | string    | null: false, unique: true |
| encrypted_password | string  | null: false |

### Association

- has_many :tweets
- has_many :comments

## tweetsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| question         | text       | null: false |
| answer           | string     | null: false |
| 1st_incorrection | string     | null: false |
| 2nd_incorrection | string     | null: false |
| answer_feedback  | string     |             |
| 1st_feedback     | string     |             |
| 2nd_feedback     | string     |             |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :tweet_tag_relations

## commentsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| message          | text       |             |
| user             | references | null: false, foreign_key: true |
| tweet            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet

## tagsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| name             | string     |             |

### Association

- has_many :tweet_tag_relations


## tweet_tag_relationsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| tweet            | references | null: false, foreign_key: true |
| tag              | references | null: false, foreign_key: true |

### Association

- belongs_to :tweet
- belongs_to :tag

<br>
<br>

# README

## アプリケーション名	
  Qweet Room

## アプリケーション概要
  クイズで共有するSNS。クイズを通して多くの知見を楽しく学べ、広めることができる。<br>

## URL
  https://dashboard.heroku.com/apps/qweet-room<br>

## テスト用アカウント	
  ユーザー名：Tester01<br>
  メール：test@test.com<br>
  パスワード：tester01<br>

## 利用方法
・右上の「新規登録」または「ログイン」を押してユーザー登録<br>
・「クイズを投稿する」ボタンを押す → 新規投稿画面へ遷移<br>
・問題文と選択肢を入力 → 「投稿する」ボタンでクイズの投稿<br>
・投稿されたクイズの問題文をクリック → クイズの詳細ページへ遷移<br>
・３択のボタンを押す → 正誤によって色が変わり、フィードバックが表示。<br>
<br>

## 目指した課題解決
  自分が持つ知識を、より多くの人にクイズを通して共有できる。<br>
学生などの見る側も、多くの知見をクイズを通して楽しく学習できる。<br>
<br>

## 洗い出した要件
  ログイン・・・あらゆる方法でログイン可能<br>
  クイズ投稿・・・クイズのツイートができること<br>
  クイズ一覧表示・・・トップページに一覧で表示されること<br>
  クイズ詳細・・・詳細ページが開けること<br>
  クイズ編集・・・詳細ページから編集できること<br>
  クイズ削除・・・詳細ページから削除できること<br>
  フィードバック表示・・・クイズの選択後に解説等を表示すること<br>
  マイページ・・・自分の投稿したクイズの一覧が表示されること<br>
  コメント・・・詳細ページからコメント投稿できること<br>
  タグ付け・・・タグ付けし、タグごとに一覧で見られること<br>
  タグ検索・・・タグ検索できること<br>
  クイズ検索・・・ツイート検索できること<br>
<br>

## 実装した機能
●トップページ<br>
[![Image from Gyazo](https://i.gyazo.com/0bf5bdc6a53508dbd4184774265956e0.gif)](https://gyazo.com/0bf5bdc6a53508dbd4184774265956e0)
ランダムに３件抽出した「ピックアップクイズ」と、新規投稿順に並んだ「新規投稿クイズ」が表示。<br>
→ →様々な知見に出会えるきっかけになるため。<br><br>
●クイズ回答<br>
[![Image from Gyazo](https://i.gyazo.com/c0870b78e9f287277f34d2975da4c3a1.gif)](https://gyazo.com/c0870b78e9f287277f34d2975da4c3a1)
選択肢をクリックすると、ボタンの表示が変わり、フィードバックが表示。<br>
→ 実際にクイズ方式で楽しく知見に触れてもらうため。作り手も、興味を持ってくれたユーザーのため、フィードバックでさらに捕捉ができる。<br><br>
[![Image from Gyazo](https://i.gyazo.com/ed38d613244c337c831d8a41b9c7c0da.gif)](https://gyazo.com/ed38d613244c337c831d8a41b9c7c0da)
選択肢の順番は毎回ランダム表示。自分用に英単語の学習などにも利用可能。<br><br>

## 実装予定の機能
  タグつけ機能<br>
  タグ検索機能<br>
  <br>
  
## データベース設計
  上記テーブル設計より<br><br>

## ローカルでの動作方法
% git clone https://https://github.com/T-yama0921/qweet-room<br>
% cd qweet-room<br>
% bundle install<br>
% rails db:create<br>
% rails db:migrate<br>
% rails s<br>
