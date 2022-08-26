class OrdersController < ApplicationController

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create    
    @order_address = OrderAddress.new(order_params)
    # binding.pry
    # indexで入力した情報をOrderAddressで新規作成して、@order_addressに代入
    if @order_address.valid?
      # 代入した情報はバリデーション通過できる？
      # 通過できたら、保存してトップ画面へ
      @order_address.save
      # 上記で、orderとaddressにぞれぞれ保存されるはず
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel).merge(user_id: current_user.id, item_id: params[:item_id])

    # params.require(:order_address).permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel, item_id).merge(user_id: current_user.id) item_idがparamsの中に入っていた


    #  params.permit("???").merge(user_id: current_user.id, item_id: params[:item_id])
  end


  # def order_params
  #     params.permit(:item_id).merge(user_id: current_user.id)
  # end
  # def address_params
  #   params.permit(:post_code, :prefecture_id, :city, :banti, :tatemono, :tel).merge(order_id: @order.id)
  # end


end