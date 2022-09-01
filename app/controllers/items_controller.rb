class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
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
    if current_user.id != @item.user_id || @item.order.present?
    redirect_to root_path 
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.delete
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :detail, :category_id, :condition_id, :cost_id, :prefecture_id,
                                 :scheduled_day_id, :price, {images: []}).merge(user_id: current_user.id)
  end

  def set_action
    @item = Item.find(params[:id])
  end
end
