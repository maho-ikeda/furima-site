# README
## usersテーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birth_date      | string | null: false |

### Association
- has_many :items
- has_many :orders


## itemsテーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| name         | string     | null: false       |
| price        | string     | null: false       |
| user         | references | foreign_key: true |
| category     | string     | null: false       |
| condition    | string     | null: false       |
| delivery_fee | string     | null: false       |
| ship_area    | string     | null: false       |
| lead_time    | string     | null: false       |

### Association
- belongs_to :users
- has_one :orders

## ordersテーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| item       | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- has_one :areas

## areasテーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| user         | references | foreign_key: true |
| postal_code  | string     | null: false       |
| prefecture   | string     | null: false       |
| city         | string     | null: false       |
| addresses    | string     | null: false       |
| building     | string     |                   |
| phone_number | string     | null: false       |

### Association
- belongs_to :orders

