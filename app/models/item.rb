class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :scheduled_day
  has_one_attached :image
  # has_one :buy

  validates :item_name, :detail, :price, :image, presence: true
  with_options presence: true, format: { with: /\A(\d)+\z/ } do
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end
 #カテゴリーの選択が「---」の時は保存できないようにする,空だめ
 validates :category_id, :condition_id, :cost_id, :prefecture_id, :scheduled_day_id, numericality: { other_than: 1 , message: "can't be blank"}, presence: true
end
