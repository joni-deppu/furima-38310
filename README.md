#テーブル設計

## users テーブル

| Column              | Type   | Options     |
| --------------------| -------| ----------- |
| first_name_zenkaku  | string | null: false |
| last_name_zenkaku   | string | null: false |
| first_name_katakana | string | null: false |
| last_name_katakana  | string | null: false |
| encrypted_password  | string | null: false |
| email               | string | null: false |
| birthday            | date   | null: false |

### Association
- has_many :items
- has_many :comments
- has_many :buys

## items テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| item_name  | string     | null:false                     |
| detail     | text       | null:false                     |
| category   | string     | null:false                     |
| condition  | string     | null:false                     |
| cost       | integer    | null:false                     |
| area       | string     | null:false                     |
| day        | string     | null:false                     |
| price      | integer    | null:false                     |
| user       | references | null:false , foreign_key: true |
| comment    | references | null:false , foreign_key: true |
| buy        | references | null:false , foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_many :category
- has_many :condition
- has_many :cost
- has_many :area
- has_many :day
- has_one :buy

## comments テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| content    | text       | null:false                     |
| items      | references | null:false , foreign_key: true |
| user       | references | null:false , foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## buys テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| user       | references | null:false , foreign_key: true |
| items      | references | null:false , foreign_key: true |
| address    | references | null:false , foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- belongs_to :buy

## addresses テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| post_code  | string     | null:false                     |
| prefecture | string     | null:false                     |
| city       | string     | null:false                     |
| banti      | string     | null:false                     |
| tatemono   | string     |                                |
| tel        | integer    | null:false                     |

### Association
- has_many :buys
