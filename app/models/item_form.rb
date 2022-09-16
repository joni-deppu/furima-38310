class ItemForm
  include ActiveModel::Model

    #ItemFormクラスのオブジェクトがItemモデルの属性を扱えるようにする
    attr_accessor(
      :item_name, :detail, :category_id, :condition_id,
      :cost_id, :prefecture_id, :scheduled_day_id, :price, :user_id, :images,
      :id, :created_at, :datetime, :updated_at, :datetime,
      :tag_name
    )

    with_options presence: true do
      validates :item_name, length: { maximum: 40 }
      validates :detail, length: { maximum: 1000 }
      validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
      validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
      validates :category_id, :condition_id, :cost_id, :prefecture_id, :scheduled_day_id,
                numericality: { other_than: 1, message: "can't be blank" }
    end
    validates :tag_name,  uniqueness: true, length: { maximum: 18 }

  
    def save
      item = Item.create(
        item_name: item_name, detail: detail, category_id: category_id, condition_id: condition_id,
        cost_id: cost_id, prefecture_id: prefecture_id, scheduled_day_id: scheduled_day_id, price: price, user_id: user_id, images: images 
        )
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  
    end

    def update(params, item)
      #一度タグの紐付けを消す
      item.item_tag_relations.destroy_all

      #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
      tag_name = params.delete(:tag_name)

      #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
      tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

      #タグを保存
      tag.save if tag_name.present?
      item.update(params)
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
    end
  
end
