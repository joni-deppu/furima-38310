FactoryBot.define do
  factory :item_tag_relation do
    association :item
    association :tag

  end
end
