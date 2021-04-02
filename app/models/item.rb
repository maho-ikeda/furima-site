class Item < ApplicationRecord
  belongs_to :user
  #has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :caterory
    belongs_to :condition
    belongs_to :cost
    belongs_to :prefucture
    belongs_to :lead_time
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

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :conditon_id
    validates :cost_id
    validates :prefucture_id
    validates :lead_time_id
  end
end
