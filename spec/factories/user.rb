FactoryBot.define do
  factory :user do
    nickname { 'furima太郎' }
    email { Faker::Internet.free_email }
    password { 'test00' }
    password_confirmation { 'test00' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_date { '1930-01-01' }
  end
end
