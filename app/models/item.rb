class Item < ApplicationRecord
  belongs_to :user
  # has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :lead_time

  with_options presence: true do
    validates :image
    validates :name, { length: { maximum: 40 } }
    validates :price, numericality: { only_integer: true }, inclusion: { in: 300..9_999_999 }    
    validates :explanation, { length: { maximum: 1000 } }
    validates :category_id
    validates :condition_id
    validates :cost_id
    validates :prefecture_id
    validates :lead_time_id
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :cost_id
    validates :prefecture_id
    validates :lead_time_id
  end
end
