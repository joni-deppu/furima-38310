FactoryBot.define do
  factory :item_form do
    item_name { Faker::Name.name }
    detail    { Faker::Lorem.sentence }
    price     { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { '2' }
    condition_id { '2' }
    cost_id          { '2' }
    prefecture_id    { '2' }
    scheduled_day_id { '2' }

    tag_name    { 'レア' }
  end
end
