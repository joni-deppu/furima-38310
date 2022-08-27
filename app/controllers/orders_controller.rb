class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create    
    @order_address = OrderAddress.new(order_params)
    # indexで入力した情報をOrderAddressで新規作成して、@order_addressに代入
    if @order_address.valid?
      # 代入した情報はバリデーション通過できる？
      # 通過できたら、保存してトップ画面へ
      pay_item
      @order_address.save
      # 上記で、orderとaddressにぞれぞれ保存されるはず
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])

    # params.require(:order_address).permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel, item_id).merge(user_id: current_user.id) item_idがparamsの中に入っていた


    #  params.permit("???").merge(user_id: current_user.id, item_id: params[:item_id])
  end
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      # amount: order_params[:price],  # 商品の値段
      amount: Item.find(params[:item_id]).price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end


  # def order_params
  #     params.permit(:item_id).merge(user_id: current_user.id)
  # end
  # def address_params
  #   params.permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel).merge(order_id: @order.id)
  # end


end