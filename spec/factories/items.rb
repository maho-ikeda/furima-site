FactoryBot.define do
  factory :item do
    name { '商品1' }
    price { 1000 }
    explanation { Faker::Lorem.sentence }
    category_id { 2 }
    condition_id { 2 }
    cost_id { 2 }
    prefecture_id { 2 }
    lead_time_id { 2 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
