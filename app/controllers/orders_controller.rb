class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def order_params
    params.permit(:item_id)
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id]).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_aea641d63c142a247c007cf3"
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end