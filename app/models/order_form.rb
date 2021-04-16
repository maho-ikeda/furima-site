class OrderForm
  include ActiveModel::Model
  attr_accessor :item, :user, :price, :order, :postal_code, :prefecture, :city, :addresses, :city, :building, :phone_number

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
  end

  def save
    Order.create(item: item, user: user)
    Area.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end