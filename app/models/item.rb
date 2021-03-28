class Item < ApplicationRecord
end

with_options presence: true do
  validates :name
  validates :price
  validates :explanation
  validates :category_id
  validates :condition_id
  validates :cost_id
  validates :prefecture_id
  validates :lead_time_id
end










ーーーーーーーーーーーー
| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| name          | string     | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |
| explanation   | text       | null: false       |
| category_id   | integer    | null: false       |
| condition_id  | integer    | null: false       |
| cost_id       | integer    | null: false       |
| prefecture_id | integer    | null: false       |
| lead_time_id  | integer    | null: false       |