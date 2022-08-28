class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :banti, :tatemono, :tel, :user_id, :item_id, :token, :order_id

  with_options presence: true do
    validates :user_id, :item_id, :token, :city, :banti
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be ---" }
    validates :tel, format: { with: /\A[0-9]{10,11}\z/ }
  end
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, banti: banti, tatemono: tatemono, tel: tel,
                   order_id: order.id)
  end
end
