class OrderForm
  include ActiveModel::Model
  attr_accessor :item, :user, :price, :order, :postal_code, :prefecture_id, :city, :addresses, :city, :building, :phone_number



  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }
  end

  def save
    Order.create(item: item, user: user)
    Area.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end