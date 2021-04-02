class Item < ApplicationRecord
  belongs_to :user
  #has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :caterory

  with_options presence: true do
    validates :image
    validates :name
    validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }
    validates :explanation
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
