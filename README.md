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
| message          | text       | null: false |
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
