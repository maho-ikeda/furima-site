class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order("created_at DESC")
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:image,:name,:price,:explanation,:category_id,:condition_id,:cost_id,:prefecture_id,:lead_time_id)
  end

  #def destroy
  #  redirect_to root_path
  #end

end
