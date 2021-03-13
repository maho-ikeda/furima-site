require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    it 'ニックネームが必須であること' do
      user = User.new(nickname: '', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Nickname ニックネームを入力してください')
    end

    it 'メールアドレスが必須であること' do
      user = User.new(nickname: 'abc', email: '', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.save
      another_user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                              last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken', 'Email このメールアドレスは既に登録されています')
    end

    it 'メールアドレスは、@を含む必要があること' do
      user = User.new(nickname: 'abc', email: 'rspectesttest.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: '', password_confirmation: '', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank", 'Password パスワードは英数字混合で入力してください')
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test0', password_confirmation: 'test0', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: '000000', password_confirmation: '000000', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Password パスワードは英数字混合で入力してください')
    end

    it 'パスワードは、確認用を含めて2回入力すること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: '', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test01', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank", 'Last name 全角文字を使用してください')

      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank", 'First name 全角文字を使用してください')
    end

    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: 'yamada', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Last name 全角文字を使用してください')

      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: 'rikutaro',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('First name 全角文字を使用してください')
    end

    it 'ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: '', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana 全角カナを使用してください')

      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: '', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank", 'First name kana 全角カナを使用してください')
    end

    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: '山田', first_name_kana: 'リクタロウ', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Last name kana 全角カナを使用してください')

      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: '陸太郎', birth_date: '1930-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('First name kana 全角カナを使用してください')
    end

    it '生年月日が必須であること' do
      user = User.new(nickname: 'abc', email: 'rspectest@test.com', password: 'test00', password_confirmation: 'test00', last_name: '山田', first_name: '陸太郎',
                      last_name_kana: 'ヤマダ', first_name_kana: 'リクタロウ', birth_date: '')
      user.valid?
      expect(user.errors.full_messages).to include('Birth date 生年月日を入力してください')
    end
  end
end
