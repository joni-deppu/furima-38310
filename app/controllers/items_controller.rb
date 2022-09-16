class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid? 
       @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user.id != @item.user_id || @item.order.present?
        # @itemから情報をハッシュとして取り出し、@item_formとしてインスタンス生成する
        item_attributes = @item.attributes
        @item_form = ItemForm.new(item_attributes)  
        @item_form.tag_name = @item.tags&.first&.tag_name
  
  end

  def update
    # paramsの内容を反映したインスタンスを生成する
    @item_form = ItemForm.new(item_form_params)

    # 画像を選択し直していない場合は、既存の画像をセットする
    @item_form.images ||= @item.images.blobs

    if @item_form.valid?
      @item_form.update(item_form_params, @item)    
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

  def search

    # タグ入力のための記述
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def item_search
    # 商品検索のための記述
    @q = Item.ransack(params[:q])
    @items = @q.result
  end


  private

  def item_form_params
    params.require(:item_form).permit(:item_name, :detail, :category_id, :condition_id, :cost_id, :prefecture_id,
                                 :scheduled_day_id, :price, :tag_name, { images: [] }).merge(user_id: current_user.id)
  end

  def set_action
    @item = Item.find(params[:id])
  end
end
