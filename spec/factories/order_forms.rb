FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    price { 1000 }
    prefecture_id { 2 }
    city { '港区' }
    addresses { '青山1-1' }
    building { '山本ビル' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
