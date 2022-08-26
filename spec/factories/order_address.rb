FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    banti { '1-1' }
    tatemono { '東京ハイツ' }
    tel { '09012345678' }
    user_id { 2 }
    item_id { 2 }
  end
end