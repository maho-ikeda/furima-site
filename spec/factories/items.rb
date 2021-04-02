FactoryBot.define do
  factory :item do
    name { "アイテム1" }
    price { "1000" }
    user_id { "1" }
    explanation { "製品の説明" }
    category_id { "2" }
    condition_id { "2" }
    cost_id { "2" }
    prefecture_id { "2" }
    lead_time_id { "2" }
  end
end
