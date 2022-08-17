#テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| --------------------| -------| --------------------------|
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| first_name_zenkaku  | string | null: false               |
| last_name_zenkaku   | string | null: false               |
| first_name_katakana | string | null: false               |
| last_name_katakana  | string | null: false               |
| birthday            | date   | null: false               |

### Association
- has_many :items
- has_many :buys

## items テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| item_name        | string     | null:false                     |
| detail           | text       | null:false                     |
| category_id      | integer    | null:false                     |
| condition_id     | integer    | null:false                     |
| cost_id          | integer    | null:false                     |
| prefecture_id    | integer    | null:false                     |
| scheduled_day_id | integer    | null:false                     |
| price            | integer    | null:false                     |
| user             | references | null:false , foreign_key: true |

### Association
- belongs_to :user
- has_many :category
- has_many :condition
- has_many :cost
- has_many :prefecture
- has_many :scheduled_day
- has_one :buy

## buys テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| user       | references | null:false , foreign_key: true |
| item       | references | null:false , foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| post_code     | string     | null:false                     |
| prefecture_id | integer    | null:false                     |
| city          | string     | null:false                     |
| banti         | string     | null:false                     |
| tatemono      | string     |                                |
| tel           | string     | null:false                     |
| buy           | references | null:false , foreign_key: true |

### Association
- belongs_to :buy
