class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'パスワードは英数字混合で入力してください'

  with_options presence: true do
    validates :nickname 
    validates :birth_date
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ , message: '全角文字を使用してください' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶ一]+\z/, message: '全角カナを使用してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶ一]+\z/, message: '全角カナを使用してください' }
  end
end
