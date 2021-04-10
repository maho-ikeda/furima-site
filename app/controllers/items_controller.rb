class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :find_id, only: [:show, :edit, :update]
  before_action :move_to_index, except: [:index, :new, :show, :create]

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :explanation, :category_id, :condition_id, :cost_id, :prefecture_id,
                                 :lead_time_id).merge(user_id: current_user.id)
  end

  def find_id
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @item.user_id == current_user.id
  end

  # def destroy
  #  redirect_to root_path
  # end
end
