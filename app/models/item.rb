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
  with_options presence: true do
    validates :item_name, length: { maximum: 40 }
    validates :detail, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
    validates :category_id, :condition_id, :cost_id, :prefecture_id, :scheduled_day_id,
              numericality: { other_than: 1, message: "can't be blank" }
  end
end
