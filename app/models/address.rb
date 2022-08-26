class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :order
  belongs_to :prefecture
  # カリキュラムとは異なるが、itemの時と同様にしておく

  
end
