class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :sold_out_item, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

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
      form_clear
      render action: :index
    end
  end

  private

  def order_params
    params.permit(:item_id)
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    ).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def form_clear
    @order_form.postal_code.clear
    @order_form.prefecture_id.clear
    @order_form.city.clear
    @order_form.addresses.clear
    @order_form.building.clear
    @order_form.phone_number.clear
  end

  def sold_out_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.order.present?
  end

  def move_to_root
    redirect_to root_path if @item.user_id == current_user.id
  end
end
