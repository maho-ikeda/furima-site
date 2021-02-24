# README
## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | string | null: false               |

### Association
- has_many :items
- has_many :orders


## itemsテーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| name          | string     | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |
| category      | string     | null: false       |
| condition_id  | integer    | null: false       |
| cost_id       | integer    | null: false       |
| prefecture_id | integer    | null: false       |
| lead_time_id  | integer    | null: false       |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| item       | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :area

## areasテーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| user          | references | foreign_key: true |
| postal_code   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| addresses     | string     | null: false       |
| building      | string     |                   |
| phone_number  | string     | null: false       |

### Association
- belongs_to :order

