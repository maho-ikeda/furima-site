class OrdersController < ApplicationController
  def index
  end

  def create
    order = Order.create(order_params)
    redirect_to "/items/#{order.item.id}" 
  end

  private
  def order_params
    params.require(:order).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
