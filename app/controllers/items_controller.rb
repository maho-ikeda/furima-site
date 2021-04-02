class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end
  

  #def destroy
  #  redirect_to root_path
  #end

  #def new
  #end

end
