class OrderAddress

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :banti, :tatemono, :tel, :user_id,  :item_id  
  
  # 下記記述はカリキュラム移しただけ、後で修正
  # oreder のバリデーション
  validates :user_id, :item_id, presence: true
  # 1以上、1000000以下の整数を許可する
  # validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: "is invalid"}

  # addressのバリデーション
  # 数字3桁、ハイフン、数字4桁の並びのみ許可する
  validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  # 0以外の整数を許可する
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
  
  def save
    # 寄付情報を保存し、変数donationに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, banti: banti, tatemono: tatemono, tel: tel, order_id: order.id)
  end
end