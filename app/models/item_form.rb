class ItemForm
  include ActiveModel::Model

    #ItemFormクラスのオブジェクトがItemモデルの属性を扱えるようにする
    attr_accessor :item_name, :detail, :category_id, :condition_id,
     :cost_id, :prefecture_id, :scheduled_day_id, :price, :user_id, :images

    with_options presence: true do
      validates :item_name, length: { maximum: 40 }
      validates :detail, length: { maximum: 1000 }
      validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
      validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
      validates :category_id, :condition_id, :cost_id, :prefecture_id, :scheduled_day_id,
                numericality: { other_than: 1, message: "can't be blank" }
    end
  
    def save
      Item.create(
        item_name: item_name, detail: detail, category_id: category_id, condition_id: condition_id,
         cost_id: cost_id, prefecture_id: prefecture_id, scheduled_day_id: scheduled_day_id, price: price, user_id: user_id, images: images 
        )
    end
  
  
end
