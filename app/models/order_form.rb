class OrderForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :addresses, :city, :building,
                :phone_number, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Area.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                phone_number: phone_number, order_id: order.id)
  end
end
