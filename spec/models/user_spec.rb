require 'rails_helper'
RSpec.describe User, type: :model do
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context 'ユーザー登録ができる時' do
      it '全ての項目が必要条件を満たし、かつ存在する' do
        expect(@user).to be_valid
      end

      it 'ニックネームがあること' do
        @user.nickname = "テスト太郎"
        expect(@user).to be_valid
      end

      it 'メールアドレスがあること' do
        @user.email = "test.taro@gmail.com"
        expect(@user).to be_valid
      end

      it 'メールアドレスは、@を含むこと' do
        @user.email = "test.taro@gmail.com"
        expect(@user).to be_valid
      end

      it 'パスワードは、6文字以上かつ半角英数字混合での入力が必須であること' do
        @user.password = "test00"
        @user.password_confirmation = "test00"
        expect(@user).to be_valid
      end
    end


      context 'ユーザー登録ができない時' do
        it 'ニックネームが存在しない' do
          @user.nickname = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'メールアドレスが存在しない' do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'メールアドレスが重複している' do
          @user.email = "test.taro@gmail.com"
          @user.save
          @another_user = FactoryBot.build(:user)
          @another_user.email = "test.taro@gmail.com"
          @another_user.valid?
          expect(@another_user.errors.full_messages).to include("Email has already been taken")
        end

        it 'メールアドレスに@がない' do
          @user.email = "test.tarogmail.com"
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end

        it 'パスワードが存在しない' do
          @user.password = ""
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank", "Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードが6文字以下' do
          @user.password = "te00"
          @user.password_confirmation = "te00"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end

        it 'パスワードに半角の英文字しかない' do
          @user.password = "testab"
          @user.password_confirmation = "testab"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードが数字のみ' do
          @user.password = "000000"
          @user.password_confirmation = "000000"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードは全角では登録できないこと' do
          @user.password = "あかさたなは"
          @user.password_confirmation = "あかさたなは"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワード確認用に値が存在しない' do
          @user.password = "test00"
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'パスワードとパスワード（確認用）、値が一致していない' do
          @user.password = "test00"
          @user.password_confirmation = "test11"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it '姓が存在しない' do
          @user.last_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name 全角文字を使用してください")
        end
        
        it '姓に半角の英字が使用されている' do
          @user.last_name = "lastname"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
        end

        it '姓に半角の数字が使用されている' do
          @user.last_name = "00000"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
        end

        it '名前が存在しない' do
          @user.first_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角文字を使用してください")
        end

        it '名前に半角の英字が使用されている' do
          @user.first_name = "firstname"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
        end

        it '名前に半角の数字が使用されている' do
          @user.first_name = "00000"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
        end

        it 'カナ(姓)が存在しない' do
          @user.last_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana 全角カナを使用してください")
        end

        it 'カナ(姓)に漢字が存在する' do
          @user.last_name_kana = "山田"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana 全角カナを使用してください")
        end

        it 'カナ(姓)に数字が存在する' do
          @user.last_name_kana = "0000"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana 全角カナを使用してください")
        end

        it 'カナ(姓)に半角の英字が存在する' do
          @user.last_name_kana = "yamada"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana 全角カナを使用してください")
        end

        it 'カナ(名前)が存在しない' do
          @user.first_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana 全角カナを使用してください")
        end

        it 'カナ(名前)に漢字が存在する' do
          @user.first_name_kana = "太郎"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana 全角カナを使用してください")
        end

        it 'カナ(名前)に数字が存在する' do
          @user.first_name_kana = "0000"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana 全角カナを使用してください")
        end

        it 'カナ(名前)に半角の英字が存在する' do
          @user.first_name_kana = "taro"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana 全角カナを使用してください")
        end

        it '生年月日が存在しない' do
          @user.birth_date = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end

      end
    end
  end
end

