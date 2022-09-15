class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :scheduled_day
  has_many_attached :images
  has_one :order
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

end
